<template>
  <div class="login-container">
    <el-form
      ref="loginFormRef"
      :model="loginData"
      :rules="loginRules"
      class="login-form"
    >
      <div class="flex text-white items-center py-4 title-wrap">
        <span class="text-2xl flex-1 text-center title">
          企业管理系统
        </span>
        <lang-select class="text-white! cursor-pointer" />
      </div>

      <el-form-item prop="username">
        <div class="p-2 text-white">
          <svg-icon icon-class="user" />
        </div>
        <el-input
          ref="username"
          v-model="loginData.username"
          class="flex-1"
          size="large"
          :placeholder="$t('login.username')"
          name="username"
        />
      </el-form-item>

      <el-tooltip
        :disabled="isCapslock === false"
        content="Caps lock is On"
        placement="right"
      >
        <el-form-item prop="password">
          <span class="p-2 text-white">
            <svg-icon icon-class="password" />
          </span>
          <el-input
            v-model="loginData.password"
            class="flex-1"
            placeholder="密码"
            :type="passwordVisible === false ? 'password' : 'input'"
            size="large"
            name="password"
            @keyup="checkCapslock"
            @keyup.enter="handleLogin"
          />
          <span class="mr-2" @click="passwordVisible = !passwordVisible">
            <svg-icon
              :icon-class="passwordVisible === false ? 'eye' : 'eye-open'"
              class="text-white cursor-pointer"
            />
          </span>
        </el-form-item>
      </el-tooltip>

      <!-- 验证码 -->
      <el-form-item prop="verifyCode">
        <span class="p-2 text-white">
          <svg-icon icon-class="verify_code" />
        </span>
        <el-input
          v-model="loginData.verifyCode"
          auto-complete="off"
          :placeholder="$t('login.verifyCode')"
          class="w-[60%]"
          @keyup.enter="handleLogin"
        />

        <div class="captcha">
          <img :src="captchaBase64" @click="getCaptcha"  alt=""/>
        </div>
      </el-form-item>

      <el-button
        size="default"
        :loading="loading"
        type="primary"
        class="w-full"
        @click.prevent="handleLogin"
        >{{ $t("login.login") }}
      </el-button>
      <div @click="openReset">
        <a style="float: right; color: #ffffff"> 忘记密码？ </a>
      </div>
    </el-form>
    <el-dialog
      v-model="resetDialog.visible"
      :title="resetDialog.title"
      append-to-body
      width="500px"
      @close="closeResetDialog"
      style="background-color: #2d3a4b"
    >
      <template #header>
        <div style="color: #90caf9">
          {{ verifyDialog.title }}
        </div>
      </template>
      <el-form
        ref="resetFormRef"
        :model="resetForm"
        :rules="resetRules"
        label-width="40px"
      >
        <el-form-item prop="username">
          <div class="p-2 text-white">
            <svg-icon icon-class="user" />
          </div>
          <el-input
            ref="username"
            v-model="resetForm.username"
            v-shake
            placeholder=" 用户名"
            class="flex-1"
            name="username"
            size="large"
          />
        </el-form-item>
        <el-form-item prop="email">
          <span class="p-2 text-white">
            <svg-icon icon-class="verify_code" />
          </span>
          <el-input
            v-model="resetForm.email"
            v-shake
            :placeholder="'请输入邮箱'"
            auto-complete="off"
            class="w-[60%]"
            @keyup.enter="handleLogin"
          />
          <el-button
            :disabled="isDisposed"
            type="primary"
            @click="getEmail('RESET_PASSWORD')"
          >
            {{ isDisposed ? `${emailTime}s后重新获取` : "获取验证码" }}
          </el-button>
        </el-form-item>
        <el-form-item prop="verifyCode">
          <el-input
            ref="verifyCode"
            v-model="resetForm.verifyCode"
            v-shake
            style="margin-left: 35px"
            placeholder="输入验证码"
            class="flex-1"
            name="emailCode"
            size="large"
          />
        </el-form-item>
        <el-form-item prop="password">
          <span class="p-2 text-white">
            <svg-icon icon-class="password" />
          </span>
          <el-input
            v-model="resetForm.password"
            v-shake
            :type="!passwordVisible ? 'password' : 'input'"
            class="flex-1"
            name="password"
            placeholder="新密码"
            size="large"
            @keyup="checkCapslock"
            @keyup.enter="handleLogin"
          />
          <span class="mr-2" @click="passwordVisible = !passwordVisible">
            <svg-icon
              :icon-class="!passwordVisible ? 'eye' : 'eye-open'"
              class="text-white cursor-pointer"
            />
          </span>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="reset">重 置</el-button>
          <el-button @click="closeResetDialog">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import router from "@/router";
import LangSelect from "@/components/LangSelect/index.vue";
import SvgIcon from "@/components/SvgIcon/index.vue";

// 状态管理依赖
import { useUserStore } from "@/store/modules/user";

// API依赖
import { LocationQuery, LocationQueryValue, useRoute } from "vue-router";
import { getCaptchaApi } from "@/api/auth";
import { LoginData } from "@/api/auth/types";
import {getEmailCode, resetPassword} from "@/api/user";

const userStore = useUserStore();
const route = useRoute();

/**
 * 按钮loading
 */
const loading = ref(false);
/**
 * 是否大写锁定
 */
const isCapslock = ref(false);
/**
 * 密码是否可见
 */
const passwordVisible = ref(false);
/**
 * 验证码图片Base64字符串
 */
const captchaBase64 = ref();

/**
 * 登录表单引用
 */
const loginFormRef = ref(ElForm);
const resetFormRef = ref(ElForm);

const loginData = ref<LoginData>({
  username: "",
  password: "",
});
const resetRules = {};
const loginRules = {
  username: [{ required: true, trigger: "blur" }],
  password: [{ required: true, trigger: "blur", validator: passwordValidator }],
  verifyCode: [{ required: true, trigger: "blur" }],
};
const resetForm = reactive<LoginData>(<LoginData>{});
const isDisposed = ref(false);
const resetDialog = reactive<DialogOption>({
    title: "找回密码",
    visible: false,
});
const emailTime = ref(60);

function openReset() {
    resetDialog.visible = true;
}

function reset() {
    resetFormRef.value.validate((valid) => {
        if (valid) {
            resetPassword(resetForm).then(() => {
                loginData.value.username = resetForm.username;
                loginData.value.password = resetForm.password;
                resetDialog.visible = false;
            });
        }
    });
}
function startTime() {
    const startTime = Number(sessionStorage.getItem("startTimeLogin"));
    const nowTime = new Date().getTime();
    if (startTime) {
        const time = 60 - (nowTime - startTime) / 1000;
        if (time < 0) {
            isDisposed.value = false;
            emailTime.value = 60;
            sessionStorage.removeItem("startTimeLogin");
        } else {
            emailTime.value = Number(time.toFixed(0));
            isDisposed.value = true;
        }
    } else {
        emailTime.value = 60;
        isDisposed.value = false;
    }
}


function getEmail(type: string) {
    let email = "";
    if (type === "RESET_PASSWORD") {
        email = resetForm.email || "";
    } else {
        email = loginData.value.email || "";
    }
    const regEmail = /[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+/;
    if (!regEmail.test(email)) {
        ElMessage.error("电子邮件格式不正确");
        return;
    }
    startTime();
    if (isDisposed.value) {
        return;
    }
    getEmailCode(email, type).then(() => {
        ElMessage.success("验证码已发送");
        isDisposed.value = true;
        sessionStorage.setItem("startTimeLogin", String(new Date().getTime()));
        handleTimeChange();
    });
}

const handleTimeChange = () => {
    if (emailTime.value <= 0) {
        isDisposed.value = false;
        emailTime.value = 60;
        sessionStorage.removeItem("startTimeLogin");
    } else {
        setTimeout(() => {
            emailTime.value--;
            handleTimeChange();
        }, 1000);
    }
};
const verifyDialog = reactive<DialogOption>({
    title: "学生认证",
    visible: false,
});


function closeResetDialog() {
    resetDialog.visible = false;
    console.log(resetFormRef.value);
    resetFormRef.value.resetFields();
    resetFormRef.value.clearValidate();
}

/**
 * 密码校验器
 */
function passwordValidator(rule: any, value: any, callback: any) {
  if (value.length < 6) {
    callback(new Error("The password can not be less than 6 digits"));
  } else {
    callback();
  }
}

/**
 * 检查输入大小写状态
 */
function checkCapslock(e: any) {
  const { key } = e;
  isCapslock.value = key && key.length === 1 && key >= "A" && key <= "Z";
}

/**
 * 获取验证码
 */
function getCaptcha() {
  getCaptchaApi().then(({ data }) => {
    const { verifyCodeBase64, verifyCodeKey } = data;
    loginData.value.verifyCodeKey = verifyCodeKey;
    captchaBase64.value = verifyCodeBase64;
  });
}

/**
 * 登录
 */
function handleLogin() {
  loginFormRef.value.validate((valid: boolean) => {
    if (valid) {
      loading.value = true;
      userStore
        .login(loginData.value)
        .then(() => {
          const query: LocationQuery = route.query;

          const redirect = (query.redirect as LocationQueryValue) ?? "/";
          const otherQueryParams = Object.keys(query).reduce(
            (acc: any, cur: string) => {
              if (cur !== "redirect") {
                acc[cur] = query[cur];
              }
              return acc;
            },
            {}
          );

          router.push({ path: redirect, query: otherQueryParams });
        })
        .catch(() => {
          // 验证失败，重新生成验证码
          getCaptcha();
        })
        .finally(() => {
          loading.value = false;
        });
    }
  });
}

onMounted(() => {
  getCaptcha();
});
</script>

<style lang="scss" scoped>
.login-container {
  width: 100%;
  min-height: 100%;
  overflow: hidden;
  background-color: #2d3a4b;

  .title-wrap {
    filter: contrast(30);

    .title {
      letter-spacing: 4px;
      animation: showup 3s forwards;
    }

    @keyframes showup {
      0% {
        letter-spacing: -20px;
      }

      100% {
        letter-spacing: 4px;
      }
    }
  }

  .login-form {
    width: 520px;
    max-width: 100%;
    padding: 160px 35px 0;
    margin: 0 auto;
    overflow: hidden;

    .captcha {
      position: absolute;
      top: 0;
      right: 0;

      img {
        width: 120px;
        height: 48px;
        cursor: pointer;
      }
    }
  }
}

.el-form-item {
  background: rgb(0 0 0 / 10%);
  border: 1px solid rgb(255 255 255 / 10%);
  border-radius: 5px;
}

.el-input {
  background: transparent;

  // 子组件 scoped 无效，使用 :deep
  :deep(.el-input__wrapper) {
    padding: 0;
    background: transparent;
    box-shadow: none;

    .el-input__inner {
      color: #fff;
      background: transparent;
      border: 0;
      border-radius: 0;
      caret-color: #fff;

      &:-webkit-autofill {
        box-shadow: 0 0 0 1000px transparent inset !important;
        -webkit-text-fill-color: #fff !important;
      }

      // 设置输入框自动填充的延迟属性
      &:-webkit-autofill,
      &:-webkit-autofill:hover,
      &:-webkit-autofill:focus,
      &:-webkit-autofill:active {
        transition: color 99999s ease-out, background-color 99999s ease-out;
        transition-delay: 99999s;
      }
    }
  }
}
</style>

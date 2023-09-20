<script setup lang="ts">
import { useUserStore } from "@/store/modules/user";
import { useTransition, TransitionPresets } from "@vueuse/core";

defineOptions({
  // eslint-disable-next-line
  name: "Dashboard",
  inheritAttrs: false,
});

const userStore = useUserStore();

const date: Date = new Date();

const username = userStore.user.nickname;
const roles = userStore.user.roles;
const form = ref<SysUser>({
  name: userStore.nickname,
  id: userStore.id,
  userId: userStore.userId,
  email: "",
  avatar: userStore.avatar,
  code: "",
});

const dialogFormVisible = ref(false);

const headers = reactive({
  Authorization: userStore.token,
});

const email = ref();
const modifyE = ref(true);

const emailTime = ref(60);
const isDisposed = ref(false);


function getEmail() {
  const regEmail = /[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(.[a-zA-Z0-9_-]+)+/;
  if (!regEmail.test(email.value)) {
    ElMessage.error("电子邮件格式不正确");
    return;
  }
  startTime();
  if (isDisposed.value) {
    return;
  }
  getEmailCode(email.value, "RESET_PASSWORD").then(() => {
    ElMessage.success("验证码已发送至邮箱，请注意查收");
    modifyE.value = false;
    isDisposed.value = true;
    sessionStorage.setItem("startTimeLogin", String(new Date().getTime()));
    handleTimeChange();
  });
}

const greetings = computed(() => {
  const hours = date.getHours();
  if (hours >= 6 && hours < 8) {
    return "晨起披衣出草堂，轩窗已自喜微凉🌅！";
  } else if (hours >= 8 && hours < 12) {
    return "上午好🌞！";
  } else if (hours >= 12 && hours < 18) {
    return "下午好☕！";
  } else if (hours >= 18 && hours < 24) {
    return "晚上好🌃！";
  } else if (hours >= 0 && hours < 6) {
    return "偷偷向银河要了一把碎星，只等你闭上眼睛撒入你的梦中，晚安🌛！";
  }
});
const imageType = ["image/jpeg", "image/png", "image/gif"];
const beforeAvatarUpload: UploadProps["beforeUpload"] = (rawFile) => {
  if (!rawFile.type) {
    ElMessage.error("错误文件");
    return false;
  } else if (!imageType.includes(rawFile.type)) {
    ElMessage.error("支支持jpeg/png/gif格式的图片");
    return false;
  } else if (rawFile.size / 1024 / 1024 > 2) {
    ElMessage.error("图片大小不能大于2MB");
    return false;
  }
  return true;
};


function modifyUser() {
  if (form.value.name === "") {
    ElMessage.error("用户名不能为空");
    return;
  }
  if (!modifyE.value) {
    console.log(modifyE);
    if (
        form.value.email !== "" &&
        form.value.password !== "" &&
        form.value.code === ""
    ) {
      ElMessage.error("验证码不能为空");
      return;
    }
  }
  modifyInfo({ email: email.value, code: form.value.code }, form.value).then(
      () => {
        ElMessage.success("修改成功");
        dialogFormVisible.value = false;
        userStore.logout();
      }
  );
}

const duration = 5000;

// 收入金额
const amount = ref(0);
const amountOutput = useTransition(amount, {
  duration: duration,
  transition: TransitionPresets.easeOutExpo,
});
amount.value = 2000;

// 访问数
const visitCount = ref(0);
const visitCountOutput = useTransition(visitCount, {
  duration: duration,
  transition: TransitionPresets.easeOutExpo,
});
visitCount.value = 2000;

//消息数
const messageCount = ref(0);
const messageCountOutput = useTransition(messageCount, {
  duration: duration,
  transition: TransitionPresets.easeOutExpo,
});
messageCount.value = 2000;

// 订单数
const orderCount = ref(0);
const orderCountOutput = useTransition(orderCount, {
  duration: duration,
  transition: TransitionPresets.easeOutExpo,
});
orderCount.value = 2000;
</script>

<template>
  <div class="dashboard-container">

    <!-- 用户信息 -->
    <el-row class="mb-8">
      <el-card class="w-full">
        <div class="flex justify-between flex-wrap">
          <div class="flex items-center">
            <img :src="userStore.user.avatar" class="user-avatar"  alt=""/>
            <span class="ml-[10px] text-[16px]">
              {{ userStore.user.nickname }}
            </span>
          </div>

          <div class="leading-[40px]">
            {{ greetings }}
          </div>

          <div class="space-x-2 flex items-center justify-end">
            <el-divider direction="vertical" />
            <el-link
                target="_blank"
                type="success"
                @click="dialogFormVisible = true"
            >修改个人信息
            </el-link>
            <el-divider direction="vertical" />
          </div>
        </div>
      </el-card>
    </el-row>

    <el-dialog v-model="dialogFormVisible" title="Shipping address">
      <el-form :model="form">
        <el-form-item label="修改头像">
          <el-upload
              :before-upload="beforeAvatarUpload"
              :headers="headers"
              :on-success="handleAvatarSuccess"
              :show-file-list="false"
              action="http://localhost:8080/api/v1/files/avatar"
              class="avatar-uploader"
          >
            <img :src="form.avatar" class="avatar" />
          </el-upload>
        </el-form-item>
        <el-form-item label="用户名：">
          <el-input v-model="form.name" autocomplete="off" />
        </el-form-item>
        修改邮箱：
        <el-form-item label="原邮箱： ">
          <el-row style="width: 100%">
            <el-col :span="21">
              <el-input v-model="email" autocomplete="off" />
            </el-col>
            <el-col :span="2">
              <el-button
                  :disabled="isDisposed"
                  type="primary"
                  @click="getEmail"
              >
                {{ isDisposed ? `${emailTime}s后重新获取` : "获取验证码" }}
              </el-button>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="验证码：">
          <el-input
              v-model="form.code"
              :disabled="modifyE"
              autocomplete="off"
          />
        </el-form-item>
        <el-form-item label="修改邮箱：">
          <el-input
              v-model="form.email"
              :disabled="modifyE"
              autocomplete="off"
          />
        </el-form-item>
        <el-form-item label="修改密码： ">
          <el-input
              v-model="form.password"
              :disabled="modifyE"
              autocomplete="off"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取消</el-button>
          <el-button type="primary" @click="modifyUser"> 确定修改 </el-button>
        </span>
      </template>
    </el-dialog>

    <!-- 数据卡片 -->
    <el-row :gutter="40" class="mb-4">
      <el-col :xs="24" :sm="12" :lg="6" class="mb-4">
        <div class="data-box">
          <div
            class="text-[#40c9c6] hover:!text-white hover:bg-[#40c9c6] p-3 rounded"
          >
            <svg-icon icon-class="uv" size="3em" />
          </div>
          <div class="flex flex-col space-y-3">
            <div class="text-[var(--el-text-color-secondary)]">访问数</div>
            <div class="text-lg text-right">
              {{ Math.round(visitCountOutput) }}
            </div>
          </div>
        </div>
      </el-col>

      <!--消息数-->
      <el-col :xs="24" :sm="12" :lg="6" class="mb-4">
        <div class="data-box">
          <div
            class="text-[#36a3f7] hover:!text-white hover:bg-[#36a3f7] p-3 rounded"
          >
            <svg-icon icon-class="message" size="3em" />
          </div>
          <div class="flex flex-col space-y-3">
            <div class="text-[var(--el-text-color-secondary)]">消息数</div>
            <div class="text-lg text-right">
              {{ Math.round(messageCountOutput) }}
            </div>
          </div>
        </div>
      </el-col>

      <el-col :xs="24" :sm="12" :lg="6" class="mb-4">
        <div class="data-box">
          <div
            class="text-[#f4516c] hover:!text-white hover:bg-[#f4516c] p-3 rounded"
          >
            <svg-icon icon-class="money" size="3em" />
          </div>
          <div class="flex flex-col space-y-3">
            <div class="text-[var(--el-text-color-secondary)]">收入金额</div>
            <div class="text-lg text-right">
              {{ Math.round(amountOutput) }}
            </div>
          </div>
        </div>
      </el-col>
      <el-col :xs="24" :sm="12" :lg="6" class="mb-2">
        <div class="data-box">
          <div
            class="text-[#34bfa3] hover:!text-white hover:bg-[#34bfa3] p-3 rounded"
          >
            <svg-icon icon-class="shopping" size="3em" />
          </div>
          <div class="flex flex-col space-y-3">
            <div class="text-[var(--el-text-color-secondary)]">订单数</div>
            <div class="text-lg text-right">
              {{ Math.round(orderCountOutput) }}
            </div>
          </div>
        </div>
      </el-col>
    </el-row>

    <!-- Echarts 图表 -->
    <el-row :gutter="40">
      <el-col :sm="24" :lg="8" class="mb-2">
        <BarChart
          id="barChart"
          height="400px"
          width="100%"
          class="bg-[var(--el-bg-color-overlay)]"
        />
      </el-col>

      <el-col :xs="24" :sm="12" :lg="8" class="mb-2">
        <PieChart
          id="pieChart"
          height="400px"
          width="100%"
          class="bg-[var(--el-bg-color-overlay)]"
        />
      </el-col>

      <el-col :xs="24" :sm="12" :lg="8" class="mb-2">
        <RadarChart
          id="radarChart"
          height="400px"
          width="100%"
          class="bg-[var(--el-bg-color-overlay)]"
        />
      </el-col>
    </el-row>
  </div>
</template>

<style lang="scss" scoped>
.dashboard-container {
  position: relative;
  padding: 24px;

  .user-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
  }

  .github-corner {
    position: absolute;
    top: 0;
    right: 0;
    z-index: 1;
    border: 0;
  }

  .data-box {
    display: flex;
    justify-content: space-between;
    padding: 20px;
    font-weight: bold;
    color: var(--el-text-color-regular);
    background: var(--el-bg-color-overlay);
    border-color: var(--el-border-color);
    box-shadow: var(--el-box-shadow-dark);
  }

  .svg-icon {
    fill: currentcolor !important;
  }
}
</style>

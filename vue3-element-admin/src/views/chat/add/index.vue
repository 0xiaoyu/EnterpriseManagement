<script lang="ts" setup>
import {listDeptOptions} from "@/api/dept";
import {noticeForm} from "@/api/notice/types";
const deptList = ref()

listDeptOptions().then(({data}) => {
  deptList.value = data
})
const formData = reactive<noticeForm>({
})


function addNotice(){
  console.log(formData)
}
</script>

<template>
  <el-card title="发布通知">
    <el-card shadow="never">
      <el-input
          v-model="formData.receiveId"
          placeholder="请输入发送人id，多位用英文逗号隔开"
      />
      <div>
      <el-tree-select
          style="width: 100vh"
          v-model="formData.deptId"
          placeholder="请选择所属部门"
          :data="deptList"
          filterable
          multiple
          check-strictly
          :render-after-expand="false"
      />
        <el-button type="primary" @click="addNotice">发布</el-button>
      </div>
    </el-card>
    <el-input
        v-model="formData.title"
        placeholder="请输入标题"
        maxlength="100"
    />
    <el-input
        v-model="formData.textarea"
        :rows="5"
        placeholder="请输入内容"
        type="textarea"
        maxlength="1000"
    />
  </el-card>
</template>

<style lang="scss" scoped>

</style>

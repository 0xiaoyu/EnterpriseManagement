<script setup lang="ts">

import {NoticeVo} from "@/api/notice/types";
import {listRead} from "@/api/notice";
import Stomp from "stompjs";
import SockJS from "sockjs-client";
import {useUserStoreHook} from "@/store/modules/user";

const userStore = useUserStoreHook();
const dataList = ref<NoticeVo[]>([]);
const query = reactive({
  pageNum: 1,
  pageSize: 20
})
listRead(query).then(({data}) => {
  dataList.value = data.list
})


const socketEndpoint = ref("http://localhost:8989/ws");

let stompClient: Stomp.Client;
console.log(userStore.user)
function connectWebSocket() {
  let socket = new SockJS(socketEndpoint.value);

  stompClient = Stomp.over(socket);

  stompClient.connect(
      { Authorization: userStore.token },
      () => {
        stompClient.subscribe("/notice/all", (res) => {
          console.log("广播消息接收", res);
        });

        stompClient.subscribe(`/notice/dept/${userStore.user.deptId}`,(res)=>{
          console.log("部门消息接收", res);
        })

        stompClient.subscribe("/user/queue/greeting", (res) => {
          console.log("点对点消息接收", res);
        });
      },
      (error) => {
        // 连接断开时触发此回调函数
        console.error("WebSocket 连接断开", error);
      }
  );
}

function disconnectWebSocket() {
  if (stompClient && stompClient.connected) {
    stompClient.disconnect(() => {
      // 在这里执行断开连接后的操作
    });
  }
}
onMounted(() => {
  connectWebSocket();
});

</script>

<template>
  <el-card v-for="notice in dataList" :key="notice.id" style="border-radius: 30px;margin: 0 5%">
    <template #header>
      <div
        class="card-header"
        style="border-radius: 10px;margin-left: 20px"
      >
        <template v-if="notice.isRead">
          <span style="float: right;margin-right: 0;margin-left: auto;">未读</span>
        </template>
        <div>{{ notice.title }}</div>
        <div style="font-size: 14px">发布人:{{ notice.name }}</div>
      </div>
    </template>
    <div style="margin-left: 20px;font-size: 16px">{{ notice.msg}}</div>
  </el-card>
</template>

<style scoped lang="scss">

</style>

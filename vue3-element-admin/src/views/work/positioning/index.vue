<template>
  <div class="login-box">
    <div class="form">
      <el-card shadow="always">
        <div class="item">
          <div class="tilte">
            <span>{{ title }}</span>
          </div>
        </div>
        <div class="item">
          <el-button
              type="primary"
              size="large"
              :loading="loading"
              @click="handleVerifyFace"
          >打卡</el-button
          >
        </div>
        <router-link v-if="form.role === 'teacher'" to="/statisticInfo"
        >统计信息</router-link
        >
        <baidu-map
            class="bm-view"
            :center="center"
            :zoom="zoom"
            ak="v5Yo8D5MFgZhv2WzUY4gpNhQbaaXWwMI"
            :scroll-wheel-zoom="true"
            @ready="handler"
        >
        </baidu-map>
      </el-card>
    </div>
    <el-dialog v-model="dialogVisible" :title="tipsTitle" width="30%">
      <span>{{ tipsContent }}</span>
      <template #footer>
        <span class="dialog-footer">
          <el-button type="primary" @click="dialogVisible = false">
            好的
          </el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>
<script setup>
/* eslint-disable */
import { onMounted, reactive, ref } from "vue";
import {useUserStore} from "@/store/modules/user";
/**
 * 属性
 */
const title = ref("考勤打卡");
const loading = ref(true);
const form = reactive({
  username: "",
  role: "",
});
let dialogVisible = ref(false);
let tipsContent=ref("");
let tipsTitle=ref("");
let localAddress=ref("");
const isShowAnchor = ref(false);
let BMapObj = reactive({});
let mapObj = reactive({});
let center = reactive({ lng: 109.45744048529967, lat: 36.49771311230842 });
let zoom = 15;
const userStore = useUserStore();

function handler({ BMap, map }) {
  // 保存百度地图类
  console.log("BMap:", BMap);
  console.log("map:", map);
  BMapObj = { ...BMap };
  mapObj = { ...map };
  zoom = 20;
  const geolocation = new BMap.Geolocation();
  console.log("geolocation:", geolocation);
  geolocation.getCurrentPosition((res) => {
    // IP地址赋值给locations对象
    console.log("getCurrentPosition:", res);
    center.lng = res.point.lng;
    center.lat = res.point.lat;
    isShowAnchor.value = true;
    var marker = new BMap.Marker(res.point); // 创建标注
    var circle = new BMap.Circle(res.point, 60, { strokeColor: "Red", strokeWeight: 6, strokeOpacity: 0.7, Color: "Red", fillColor: "#f03" });
    map.addOverlay(marker);
    map.addOverlay(circle);
    localAddress = res.address.province + res.address.city + res.address.district + res.address.street + res.address.street_number;
    var label = new BMap.Label(`${res.address.province + res.address.city + res.address.district + res.address.street + res.address.street_number}`, { offset: new BMap.Size(20, -10) }); //标注标签
    marker.setLabel(label); //设置标注说明
    loading.value = false;
  });
}
onMounted(() => {
  form.username = 'admin';
  form.role = 'ROOT';
});
</script>
<style scoped>
.bm-view {
  display: flex;
  height: 600px;
  width: auto;
  .BMap_cpyCtrl {
    display: none;
  }
  .anchorBL {
    display: none;
  }
}

.login-box {
  display: flex;
  flex-direction: row;
  width: 100%;
  height: 100%;
  align-items: center;
  justify-content: center;
  background-size: 100% 100%;
  border-radius: 5px;
  .form {
    width: 1200px;
    height: 1000px;
    align-items: center;
    align-content: center;
    text-align: center;
    .el-card {
      height: 100%;
      border-radius: 20px;
    }
    .item {
      margin: 20px 0;
    }
    .el-button {
      width: 100%;
    }
    .tilte {
      font-size: 30px;
      margin-bottom: 20px;
    }

  }
}
</style>

<script lang="ts" setup>
import {ElLoading} from "element-plus";
import {PageWorkExcParam, WorkExcLog} from "@/api/workExc/types";
import {deleteWorkExc, exportWorkExc, getAllWorkExcType, pageWorkExc} from "@/api/workExc";
import {listDeptOptions} from "@/api/dept";
import {deleteUsers} from "@/api/user";

const queryFormRef = ref(ElForm); // 查询表单

const searchDeptName = ref();
const deptList = ref<OptionType[]>();
const loading = ref(false);
const queryParams = reactive<PageWorkExcParam>({
  pageNum: 1,
  pageSize: 20,
  type: '迟到'
});
const dataList = ref<WorkExcLog[]>();
const now = new Date();
const startTime = new Date(now.getFullYear(), now.getMonth(), now.getDate(), 0, 0, 0);
const times = ref<[Date, Date]>([
  startTime,
  now,
])
const total = ref(0);
const typeList = ref([])
const ids = ref([]);

const shortcuts = [
  {
    text: '一天',
    value: () => {
      const start = new Date()
      start.setTime(start.getTime() - 3600 * 1000 * 24)
      return [start, now]
    },
  },
  {
    text: '两天',
    value: () => {
      const start = new Date()
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 2)
      return [start, now]
    },
  },
  {
    text: '上周',
    value: () => {
      const start = new Date()
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 7)
      return [start, now]
    },
  },
  {
    text: '上个月',
    value: () => {
      const start = new Date()
      start.setTime(start.getTime() - 3600 * 1000 * 24 * 30)
      return [start, now]
    },
  }
]

/**
 * 查询
 */
function handleQuery() {
  loading.value = true;
  queryParams.startTime = times.value[0].toLocaleString()
  queryParams.endTime = times.value[1].toLocaleString()
  pageWorkExc(queryParams).then(({data}) => {
    dataList.value = data.list;
    total.value = data.total;
  }).finally(() => {
    loading.value = false;
  })
}

/**
 * 导出表格
 */
function handleExport() {
  const loading = ElLoading.service({
    lock: true,
    text: '导出中',
    background: 'rgba(0, 0, 0, 0.7)',
  })
  queryParams.startTime = times.value[0].toLocaleString()
  queryParams.endTime = times.value[1].toLocaleString()
  exportWorkExc(queryParams).then((response: any) => {
    const blob = new Blob([response.data], {
      type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8",
    });
    const a = document.createElement("a");
    const href = window.URL.createObjectURL(blob); // 下载的链接
    a.href = href;
    a.download = decodeURI(
      response.headers["content-disposition"].split(";")[1].split("=")[1]
    ); // 获取后台设置的文件名称
    document.body.appendChild(a);
    a.click(); // 点击导出
    document.body.removeChild(a); // 下载完成移除元素
    window.URL.revokeObjectURL(href); // 释放掉blob对象
    loading.close();
  });
}

/** 重置查询 */
function resetQuery() {
  queryFormRef.value.resetFields();
  queryParams.pageNum = 1;
  times.value = [startTime, now]
  handleQuery();
}

/**
 * 获取部门下拉项
 */
async function getDeptOptions() {
  listDeptOptions().then((response) => {
    deptList.value = response.data;
  });
}
/**
 * 部门筛选
 */
function handleDeptFilter(value: string, data: any) {
  if (!value) {
    return true;
  }
  return data.label.indexOf(value) !== -1;
}
/**
 * 部门树节点
 */
function handleDeptNodeClick(data: { [key: string]: any }) {
  queryParams.deptId = data.value;
  handleQuery();
}

getAllWorkExcType().then(({data}) => {
  typeList.value = data
})

function handleDelete(id?: number) {
  const workExcId = [id || ids.value].join(",");
  if (!workExcId) {
    ElMessage.warning("请勾选删除项");
    return;
  }

  ElMessageBox.confirm("确认删除用户?", "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning",
  }).then(function () {
    deleteWorkExc(workExcId).then(() => {
      ElMessage.success("删除成功");
      resetQuery();
    });
  });
}

onMounted(() => {
  getDeptOptions(); // 初始化部门
  // handleQuery(); // 初始化用户列表数据
});
</script>

<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!-- 部门树 -->
      <el-col :lg="4" :xs="24" class="mb-[12px]">
        <el-card shadow="never">
          <el-input v-model="searchDeptName" clearable placeholder="部门名称">
            <template #prefix>
              <i-ep-search/>
            </template>
          </el-input>

          <el-tree
            ref="deptTreeRef"
            :data="deptList"
            :expand-on-click-node="false"
            :filter-node-method="handleDeptFilter"
            :props="{ children: 'children', label: 'label', disabled: '' }"
            class="mt-2"
            default-expand-all
            @node-click="handleDeptNodeClick"
          />
        </el-card>
      </el-col>
      <el-col :lg="20" :xs="24">

        <div class="search-container">
          <el-form ref="queryFormRef" :inline="true" :model="queryParams">
            <el-form-item label="姓名" prop="phoneNumber">
              <el-input
                v-model="queryParams.name"
                clearable
                placeholder="姓名"
                style="width: 200px"
                @keyup.enter="handleQuery"
              />
            </el-form-item>
            <el-form-item label="违规类型" prop="phoneNumber">
              <el-select v-model="queryParams.type">
                <el-option v-for="item in typeList" :key="item" :label="item" :value="item"/>
              </el-select>
            </el-form-item>

            <el-form-item label="时间" prop="times">
              <el-date-picker
                v-model="times"
                :shortcuts="shortcuts"
                end-placeholder="结束时间"
                range-separator="To"
                start-placeholder="起始时间"
                type="daterange"
                @change="handleQuery"
              />
            </el-form-item>

            <el-form-item>
              <el-button type="primary" @click="handleQuery"
              >
                <i-ep-search/>
                搜索
              </el-button
              >
              <el-button @click="resetQuery">
                <i-ep-refresh/>
                重置
              </el-button
              >
            </el-form-item>
            <el-form-item>
              <div class="flex justify-between">
                <el-button class="ml-3" @click="handleExport"
                >
                  <template #icon>
                    <i-ep-download/>
                  </template>
                  导出
                </el-button>
              </div>
            </el-form-item>
          </el-form>

        </div>

        <el-card shadow="never">
          <template #header>

          </template>

          <el-table
            v-loading="loading"
            :data="dataList"
            border
          >
            <el-table-column type="selection" width="50" align="center" />
            <el-table-column
              key="id"
              align="center"
              label="人员名称"
              prop="name"
              width="300"
            />
            <el-table-column
              key="username"
              align="center"
              label="手机号"
              prop="mobile"
              width="300"
            />
            <el-table-column
              align="center"
              label="部门名称"
              prop="deptName"
              width="250"
            />

            <el-table-column
              align="center"
              label="类型"
              prop="type"
              width="100"
            />

            <el-table-column
              align="center"
              label="时间"
              prop="time"
              width="200"
            >
              <template #default="{row}">
                {{ row.time }} 分钟
              </template>
            </el-table-column>
            <el-table-column label="操作" fixed="right">
              <template #default="scope">
                <el-button
                  v-hasPerm="['sys:workExc:delete']"
                  type="primary"
                  link
                  size="small"
                  @click="handleDelete(scope.row.id)"
                ><i-ep-delete />删除</el-button
                >
              </template>
            </el-table-column>
          </el-table>

          <pagination
            v-if="total > 0"
            v-model:limit="queryParams.pageSize"
            v-model:page="queryParams.pageNum"
            v-model:total="total"
            @pagination="handleQuery"
          />
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>


<style lang="scss" scoped>

</style>

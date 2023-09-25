<script lang="ts" setup>
import {addApply, getMyApply} from "@/api/apply";
import {Apply, ApplyQuery} from "@/api/apply/types";

const dataList = ref<Apply>({})
const total = ref(0)
const loading = ref(false);
const queryParams = reactive<ApplyQuery>({
  pageNum: 1,
  pageSize: 20,
});

/**
 * 查询
 */
function handleQuery() {
  loading.value = true;
  getMyApply().then(({data}) => {
    dataList.value = data.list.map(i => {
      i.status = i.status === 0 ? '待审批' : i.status === 1 ? '已通过' : '已拒绝'
      return i
    })
    total.value = data.total
  }).finally(() => {
    loading.value = false;
  })
}

function resetQuery() {
  queryFormRef.value.resetFields();
  queryParams.pageNum = 1;
  handleQuery();
}

handleQuery()
</script>

<template>
  <div class="app-container">
    <el-row :gutter="20">
      <!-- 部门树 -->
      <el-col :lg="4" :xs="24" class="mb-[12px]">
        <el-form ref="queryFormRef" :inline="true" :model="queryParams">
          <el-form-item label="审批人姓名" prop="approvedUserId">
            <el-input v-model="queryParams.approvedUser" placeholder="审批人工号"/>
          </el-form-item>
          <el-form-item label="状态" prop="approvedUserId">
            <el-select v-model="queryParams.status">
              <el-option label="待审批" value="0"/>
              <el-option label="已通过" value="1"/>
              <el-option label="已拒绝" value="2"/>
            </el-select>
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
            <el-form-item label="申请类型" prop="phoneNumber">
              <el-select v-model="queryParams.type">
                <el-option v-for="item in typeList" :key="item" :label="item" :value="item"/>
              </el-select>
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
            <el-table-column align="center" type="selection" width="50"/>
            <el-table-column
                key="id"
                align="center"
                label="处理id"
                prop="id"
                width="300"
            />
            <el-table-column
                key="username"
                align="center"
                label="开始时间"
                prop="startTime"
                width="300"
            />
            <el-table-column
                align="center"
                label="结束时间"
                prop="endTime"
                width="250"
            />

            <el-table-column
                align="center"
                label="申请类型"
                prop="type"
                width="100"
            />

            <el-table-column
                align="center"
                label="秒速"
                prop="detail"
                width="200"
            />
            <el-table-column
                align="center"
                label="审批状态"
                prop="status"
                width="200"
            />
            <el-table-column
                align="center"
                label="审批人"
                prop="approvedUserId"
                width="200"
            />
            <el-table-column fixed="right" label="操作">
              <template #default="scope">
                <el-button
                    v-hasPerm="['sys:workExc:delete']"
                    link
                    size="small"
                    type="primary"
                    @click="handleDelete(scope.row.id)"
                >
                  <i-ep-delete/>
                  删除
                </el-button
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

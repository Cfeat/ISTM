<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="教案名称" prop="planName">
        <el-input v-model="queryParams.planName" placeholder="请输入教案名称" clearable style="width: 240px" @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="Plus" @click="handleAdd">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="Edit" :disabled="single" @click="handleUpdate">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="Delete" :disabled="multiple" @click="handleDelete">删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="warning" plain icon="Download" @click="handleExport">导出</el-button>
      </el-col>
    </el-row>

    <el-table v-loading="loading" :data="planList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="教案ID" align="center" prop="planId" />
      <el-table-column label="教案名称" align="center" prop="planName" />
      <el-table-column label="教案类型" align="center" prop="planType" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)">修改</el-button>
          <el-button link type="primary" icon="View" @click="handleView(scope.row)">查看</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination v-show="total>0" :total="total" v-model:page="queryParams.pageNum" v-model:limit="queryParams.pageSize" @pagination="getList" />

    <!-- 添加或修改教案对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="教案名称" prop="planName">
          <el-input v-model="form.planName" placeholder="请输入教案名称" />
        </el-form-item>
        <el-form-item label="教案类型" prop="planType">
          <el-select v-model="form.planType" placeholder="请选择教案类型">
            <el-option label="普通" value="普通" />
            <el-option label="足球" value="足球" />
            <el-option label="武术" value="武术" />
            <el-option label="营养" value="营养" />
            <el-option label="康复" value="康复" />
          </el-select>
        </el-form-item>
        <el-form-item label="教案内容" prop="planContent">
          <el-input v-model="form.planContent" type="textarea" placeholder="请输入内容" />
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { listPlan, getPlan, delPlan, addPlan, updatePlan } from "@/api/system/plan";
import { ref, reactive, onMounted } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';

const planList = ref([]);
const open = ref(false);
const loading = ref(false);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

// 查询参数
const queryParams = reactive({
  pageNum: 1,
  pageSize: 10,
  planName: undefined,
  planType: undefined
});

// 表单参数
const form = reactive({
  planId: undefined,
  planName: undefined,
  planType: undefined,
  planContent: undefined
});

// 表单校验
const rules = reactive({
  planName: [
    { required: true, message: "教案名称不能为空", trigger: "blur" }
  ],
  planType: [
    { required: true, message: "请选择教案类型", trigger: "change" }
  ]
});

/** 查询教案列表 */
function getList() {
  loading.value = true;
  listPlan(queryParams).then(response => {
    planList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

/** 取消按钮 */
function cancel() {
  open.value = false;
  resetForm();
}

/** 表单重置 */
function resetForm() {
  form.planId = undefined;
  form.planName = undefined;
  form.planType = undefined;
  form.planContent = undefined;
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  queryParams.planName = undefined;
  queryParams.planType = undefined;
  handleQuery();
}

/** 新增按钮操作 */
function handleAdd() {
  resetForm();
  open.value = true;
  title.value = "添加教案";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  resetForm();
  const planId = row.planId || ids.value[0];
  getPlan(planId).then(response => {
    Object.assign(form, response.data);
    open.value = true;
    title.value = "修改教案";
  });
}

/** 查看按钮操作 */
function handleView(row) {
  const planId = row.planId;
  getPlan(planId).then(response => {
    ElMessage({
      message: `教案内容: ${response.data.planContent || '暂无内容'}`,
      type: 'info',
      duration: 5000
    });
  });
}

/** 提交按钮 */
function submitForm() {
  if (form.planId) {
    updatePlan(form).then(response => {
      ElMessage.success("修改成功");
      open.value = false;
      getList();
    });
  } else {
    addPlan(form).then(response => {
      ElMessage.success("新增成功");
      open.value = false;
      getList();
    });
  }
}

/** 删除按钮操作 */
function handleDelete(row) {
  const planIds = row.planId || ids.value;
  ElMessageBox.confirm('是否确认删除？', "警告", {
    confirmButtonText: "确定",
    cancelButtonText: "取消",
    type: "warning"
  }).then(function() {
    return delPlan(planIds);
  }).then(() => {
    getList();
    ElMessage.success("删除成功");
  });
}

/** 导出按钮操作 */
function handleExport() {
  // 导出实现
}

/** 多选框选中数据 */
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.planId);
  single.value = selection.length !== 1;
  multiple.value = !selection.length;
}

onMounted(() => {
  getList();
});
</script> 
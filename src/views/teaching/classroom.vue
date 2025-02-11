<template>
  <div class="classroom-container">
    <el-card>
      <template #header>
        <div class="card-header">
          <span>虚拟课堂管理</span>
          <el-button type="primary" @click="handleCreateClassroom">
            创建课堂
          </el-button>
        </div>
      </template>

      <el-table :data="classroomList" v-loading="loading">
        <el-table-column prop="classroom_name" label="课堂名称" />
        <el-table-column prop="student_count" label="学生数量" />
        <el-table-column prop="duration" label="课程时长" />
        <el-table-column prop="created_at" label="创建时间" />
        <el-table-column label="操作" width="150">
          <template #default="scope">
            <el-button-group>
              <el-button type="primary" link @click="handleEdit(scope.row)">
                编辑
              </el-button>
              <el-button type="danger" link @click="handleDelete(scope.row)">
                删除
              </el-button>
            </el-button-group>
          </template>
        </el-table-column>
      </el-table>
    </el-card>

    <!-- 创建/编辑课堂对话框 -->
    <el-dialog
      :title="dialogTitle"
      v-model="dialogVisible"
      width="500px"
    >
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-width="100px"
      >
        <el-form-item label="课堂名称" prop="classroom_name">
          <el-input v-model="form.classroom_name" />
        </el-form-item>
        <el-form-item label="课程时长" prop="duration">
          <el-input-number v-model="form.duration" :min="1" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { getClassroomList, createClassroom } from '@/api/classroom'
import { ElMessage } from 'element-plus'

const loading = ref(false)
const classroomList = ref([])
const dialogVisible = ref(false)
const dialogTitle = ref('创建课堂')
const formRef = ref()

const form = ref({
  classroom_name: '',
  duration: 30
})

const rules = {
  classroom_name: [
    { required: true, message: '请输入课堂名称', trigger: 'blur' }
  ],
  duration: [
    { required: true, message: '请输入课程时长', trigger: 'blur' }
  ]
}

// 获取课堂列表
const fetchClassroomList = async () => {
  loading.value = true
  try {
    const data = await getClassroomList()
    classroomList.value = data
  } catch (error) {
    console.error('获取课堂列表失败:', error)
    ElMessage.error('获取课堂列表失败')
  } finally {
    loading.value = false
  }
}

// 创建课堂
const handleCreateClassroom = () => {
  dialogTitle.value = '创建课堂'
  form.value = {
    classroom_name: '',
    duration: 30
  }
  dialogVisible.value = true
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        await createClassroom(form.value)
        ElMessage.success('创建成功')
        dialogVisible.value = false
        fetchClassroomList()
      } catch (error) {
        console.error('创建失败:', error)
        ElMessage.error('创建失败')
      }
    }
  })
}

onMounted(() => {
  fetchClassroomList()
})
</script>

<style lang="scss" scoped>
.classroom-container {
  padding: 20px;

  .card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
}
</style> 
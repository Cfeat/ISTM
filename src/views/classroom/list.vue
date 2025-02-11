<template>
  <div class="classroom-list">
    <div class="list-header">
      <h2 style="color: #95d475;">AI课堂列表</h2>
      <el-button 
        type="primary" 
        style="background-color: #95d475; border-color: #95d475;"
        @click="createClassroom"
      >
        <el-icon><Plus /></el-icon>创建课堂
      </el-button>
    </div>

    <!-- 搜索栏 -->
    <el-card class="search-card">
      <el-form :inline="true" :model="searchForm">
        <el-form-item label="课程名称">
          <el-input v-model="searchForm.name" placeholder="请输入课程名称" />
        </el-form-item>
        <el-form-item label="课程类型">
          <el-select v-model="searchForm.type" placeholder="请选择课程类型">
            <el-option 
              v-for="type in courseTypes" 
              :key="type.value" 
              :label="type.label" 
              :value="type.value" 
            />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 课堂列表 -->
    <el-card class="list-content">
      <el-table :data="classroomList" v-loading="loading" border>
        <el-table-column prop="courseName" label="课程名称" min-width="150" />
        <el-table-column prop="courseType" label="课程类型" width="120" />
        <el-table-column prop="studentCount" label="学生数量" width="100">
          <template #default="{ row }">
            {{ row.studentCount }}人
          </template>
        </el-table-column>
        <el-table-column prop="duration" label="教学时长" width="100">
          <template #default="{ row }">
            {{ row.duration }}分钟
          </template>
        </el-table-column>
        <el-table-column prop="createTime" label="创建时间" width="180" />
        <el-table-column prop="status" label="状态" width="100">
          <template #default="{ row }">
            <el-tag :type="row.status === 'active' ? 'success' : 'info'">
              {{ row.status === 'active' ? '已发布' : '草稿' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="250" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" @click="viewClassroom(row)">查看</el-button>
            <el-button link type="primary" @click="startClassroom(row)">开始上课</el-button>
            <el-button link type="primary" @click="editClassroom(row)">编辑</el-button>
            <el-button link type="danger" @click="deleteClassroom(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :total="total"
          :page-sizes="[10, 20, 50, 100]"
          layout="total, sizes, prev, pager, next"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { Plus } from '@element-plus/icons-vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getCourseTypes } from '@/api/classroom'

const router = useRouter()
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const classroomList = ref([])
const courseTypes = ref([])

const searchForm = reactive({
  name: '',
  type: ''
})

// 获取课程类型
const fetchCourseTypes = async () => {
  try {
    const res = await getCourseTypes()
    courseTypes.value = res.data
  } catch (error) {
    ElMessage.error('获取课程类型失败')
  }
}

// 获取课堂列表
const fetchClassroomList = async () => {
  try {
    loading.value = true
    // TODO: 调用获取列表API
    // 模拟数据
    classroomList.value = Array(10).fill(null).map((_, index) => ({
      id: index + 1,
      courseName: `示例课程${index + 1}`,
      courseType: '篮球',
      studentCount: 30,
      duration: 45,
      createTime: '2024-02-20 10:00:00',
      status: index % 2 === 0 ? 'active' : 'draft'
    }))
    total.value = 100
  } catch (error) {
    ElMessage.error('获取课堂列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  currentPage.value = 1
  fetchClassroomList()
}

// 重置搜索
const resetSearch = () => {
  Object.keys(searchForm).forEach(key => {
    searchForm[key] = ''
  })
  handleSearch()
}

// 分页处理
const handleSizeChange = (val) => {
  pageSize.value = val
  fetchClassroomList()
}

const handleCurrentChange = (val) => {
  currentPage.value = val
  fetchClassroomList()
}

// 创建课堂
const createClassroom = () => {
  router.push('/classroom/create')
}

// 查看课堂
const viewClassroom = (row) => {
  router.push(`/classroom/detail/${row.id}`)
}

// 开始上课
const startClassroom = (row) => {
  // TODO: 实现开始上课逻辑
  ElMessage.success('课堂开始')
}

// 编辑课堂
const editClassroom = (row) => {
  router.push(`/classroom/edit/${row.id}`)
}

// 删除课堂
const deleteClassroom = async (row) => {
  try {
    await ElMessageBox.confirm('确定要删除该课堂吗？', '提示', {
      type: 'warning'
    })
    // TODO: 调用删除API
    ElMessage.success('删除成功')
    fetchClassroomList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

onMounted(() => {
  fetchCourseTypes()
  fetchClassroomList()
})
</script>

<style lang="scss" scoped>
.classroom-list {
  padding: 20px;

  .list-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;

    h2 {
      margin: 0;
    }
  }

  .search-card {
    margin-bottom: 20px;
  }

  .list-content {
    .pagination {
      margin-top: 20px;
      display: flex;
      justify-content: flex-end;
    }
  }
}
</style> 
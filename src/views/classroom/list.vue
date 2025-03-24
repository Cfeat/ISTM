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
        <el-table-column label="课程类型" width="120">
          <template #default="{ row }">
            {{ getCourseTypeLabel(row.courseType) }}
          </template>
        </el-table-column>
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
        <el-table-column label="操作" width="250" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" @click="viewClassroom(row)">查看</el-button>
            <el-button link type="primary" @click="startClass(row)">开始上课</el-button>
            <el-button link type="primary" @click="editClassroom(row)">编辑</el-button>
            <el-button link type="danger" @click="deleteClass(row)">删除</el-button>
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
import { getCourseTypes, getClassroomList, deleteClassroom, startClassroom } from '@/api/classroom'

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

const courseTypeMap = {
  basketball: '篮球课程',
  football: '足球课程',
  volleyball: '排球课程',
  athletics: '田径课程',
  gymnastics: '体操课程'
}

const getCourseTypeLabel = (type) => {
  return courseTypeMap[type] || type
}

const courseTypesOptions = [
  { value: 'basketball', label: '篮球课程' },
  { value: 'football', label: '足球课程' },
  { value: 'volleyball', label: '排球课程' },
  { value: 'athletics', label: '田径课程' },
  { value: 'gymnastics', label: '体操课程' }
]

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
    const res = await getClassroomList({
      page: currentPage.value,
      pageSize: pageSize.value,
      name: searchForm.name,
      type: searchForm.type
    })
    classroomList.value = res.data.list
    total.value = res.data.total
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

// 编辑课堂
const editClassroom = (row) => {
  router.push(`/classroom/edit/${row.id}`)
}

// 删除课堂
const deleteClass = async (row) => {
  try {
    await ElMessageBox.confirm('确定要删除该课堂吗？删除后将无法恢复', '警告', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await deleteClassroom(row.id)
    ElMessage.success('删除成功')
    fetchClassroomList() // 重新获取列表数据
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

// 开始上课
const startClass = async (row) => {
  try {
    const res = await startClassroom(row.id)
    if (res.code === 200) {
      ElMessage.success('课堂开始')
      router.push(`/classroom/room/${row.id}`)
    } else {
      throw new Error(res.message)
    }
  } catch (error) {
    ElMessage.error(error.message || '开始上课失败')
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
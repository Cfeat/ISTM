<template>
  <div class="course-container">
    <div class="header">
      <h2 style="color: #95d475;">课程管理</h2>
      <el-button 
        type="primary" 
        style="background-color: #95d475; border-color: #95d475;"
        @click="createCourse"
      >
        <el-icon><Plus /></el-icon>新建课程
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
            <el-option label="体育" value="sports" />
            <el-option label="健康" value="health" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleSearch">搜索</el-button>
          <el-button @click="resetSearch">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>

    <!-- 课程列表 -->
    <el-card class="course-list">
      <el-table :data="courseList" v-loading="loading">
        <el-table-column prop="name" label="课程名称" />
        <el-table-column prop="type" label="课程类型" />
        <el-table-column prop="createTime" label="创建时间" />
        <el-table-column prop="status" label="状态">
          <template #default="{ row }">
            <el-tag :type="row.status === 'active' ? 'success' : 'info'">
              {{ row.status === 'active' ? '已发布' : '草稿' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template #default="{ row }">
            <el-button link type="primary" @click="viewCourse(row)">查看</el-button>
            <el-button link type="primary" @click="editCourse(row)">编辑</el-button>
            <el-button link type="danger" @click="deleteCourse(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

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
import { getCourseList } from '@/api/course'

const router = useRouter()
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
const courseList = ref([])

const searchForm = reactive({
  name: '',
  type: ''
})

// 获取课程列表
const fetchCourseList = async () => {
  try {
    loading.value = true
    const params = {
      page: currentPage.value,
      pageSize: pageSize.value,
      ...searchForm
    }
    const res = await getCourseList(params)
    courseList.value = res.data.list
    total.value = res.data.total
  } catch (error) {
    ElMessage.error('获取课程列表失败')
  } finally {
    loading.value = false
  }
}

// 搜索
const handleSearch = () => {
  currentPage.value = 1
  fetchCourseList()
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
  fetchCourseList()
}

const handleCurrentChange = (val) => {
  currentPage.value = val
  fetchCourseList()
}

// 创建课程
const createCourse = () => {
  router.push('/classroom')
}

// 查看课程
const viewCourse = (row) => {
  router.push(`/course/detail/${row.id}`)
}

// 编辑课程
const editCourse = (row) => {
  router.push(`/course/edit/${row.id}`)
}

// 删除课程
const deleteCourse = async (row) => {
  try {
    await ElMessageBox.confirm('确定要删除该课程吗？', '提示', {
      type: 'warning'
    })
    // TODO: 调用删除API
    ElMessage.success('删除成功')
    fetchCourseList()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

onMounted(() => {
  fetchCourseList()
})
</script>

<style lang="scss" scoped>
.course-container {
  padding: 20px;

  .header {
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

  .course-list {
    .pagination {
      margin-top: 20px;
      display: flex;
      justify-content: flex-end;
    }
  }
}
</style> 
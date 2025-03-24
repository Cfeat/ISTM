<template>
    <div class="teaching-container">
      <div class="teaching-header">
        <el-row :gutter="20">
          <el-col :span="6">
            <el-input
              v-model="searchQuery"
              placeholder="搜索课程名称"
              clearable
              @clear="handleSearch"
              @input="handleSearch"
            >
              <template #prefix>
                <el-icon><Search /></el-icon>
              </template>
            </el-input>
          </el-col>
          <el-col :span="4">
            <el-button type="primary" @click="handleAdd">
              <el-icon><Plus /></el-icon>新增教案
            </el-button>
          </el-col>
        </el-row>
      </div>
  
      <div class="teaching-content">
        <el-row :gutter="20">
          <el-col v-for="item in filteredList" :key="item.id" :span="6">
            <el-card 
              class="teaching-card" 
              shadow="hover"
            >
              <div class="card-header">
                <span class="title">{{ item.title }}</span>
                <div class="operations">
                  <span class="duration">{{ item.duration }}分钟</span>
                  <el-dropdown trigger="hover" @command="handleCommand($event, item)">
                    <el-icon class="more-icon"><MoreFilled /></el-icon>
                    <template #dropdown>
                      <el-dropdown-menu>
                        <el-dropdown-item command="view">查看</el-dropdown-item>
                        <el-dropdown-item command="edit">编辑</el-dropdown-item>
                        <el-dropdown-item command="delete" divided>
                          <span style="color: #f56c6c">删除</span>
                        </el-dropdown-item>
                      </el-dropdown-menu>
                    </template>
                  </el-dropdown>
                </div>
              </div>
              <div class="card-tags">
                <el-tag
                  v-for="tag in item.tags"
                  :key="tag"
                  size="small"
                  :type="getTagType(tag)"
                  class="tag"
                >
                  {{ tag }}
                </el-tag>
              </div>
            </el-card>
          </el-col>
        </el-row>
      </div>
  
      <!-- 查看/编辑对话框 -->
      <el-dialog
        :title="dialogTitle"
        v-model="dialogVisible"
        width="70%"
      >
        <el-form
          ref="formRef"
          :model="teachingForm"
          :rules="rules"
          label-width="100px"
          status-icon
        >
          <el-form-item label="课程名称" prop="title">
            <el-input 
              v-model="teachingForm.title" 
              :disabled="!isEditing"
              placeholder="请输入课程名称"
            />
          </el-form-item>
          
          <el-form-item label="课程类型" prop="type">
            <el-select 
              v-model="teachingForm.type" 
              :disabled="!isEditing"
              placeholder="请选择课程类型"
              clearable
            >
              <el-option label="普通" value="普通" />
              <el-option label="足球" value="足球" />
              <el-option label="武术" value="武术" />
              <el-option label="营养" value="营养" />
              <el-option label="康复" value="康复" />
            </el-select>
          </el-form-item>
          
          <el-form-item label="课程标签" prop="tags">
            <el-select 
              v-model="teachingForm.tags" 
              multiple 
              :disabled="!isEditing"
              placeholder="请选择课程标签"
              clearable
            >
              <el-option label="小班" value="小班" />
              <el-option label="大班" value="大班" />
              <el-option label="室内" value="室内" />
            </el-select>
          </el-form-item>
          
          <el-form-item label="课程时长" prop="duration">
            <el-input-number 
              v-model="teachingForm.duration" 
              :min="1" 
              :max="120" 
              :disabled="!isEditing"
              placeholder="请输入课程时长(分钟)"
            />
          </el-form-item>
          
          <el-form-item label="教案内容" prop="content">
            <el-input
              v-model="teachingForm.content"
              type="textarea"
              :rows="10"
              :disabled="!isEditing"
              placeholder="请输入教案详细内容..."
            />
          </el-form-item>
        </el-form>
        
        <template #footer>
          <el-button @click="handleDialogClose">关闭</el-button>
          <el-button v-if="!isEditing" type="primary" @click="startEditing">编辑</el-button>
          <el-button v-if="isEditing" type="success" @click="handleSave">保存</el-button>
        </template>
      </el-dialog>

      <!-- 添加删除确认对话框 -->
      <el-dialog
        v-model="deleteDialogVisible"
        title="删除确认"
        width="30%"
        center
      >
        <span>确定要删除该教案吗？此操作不可恢复。</span>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="deleteDialogVisible = false">取消</el-button>
            <el-button type="danger" @click="confirmDelete">确定</el-button>
          </span>
        </template>
      </el-dialog>
    </div>
  </template>
  
  <script setup>
  import { ref, computed } from 'vue'
  import { Search, Plus, MoreFilled } from '@element-plus/icons-vue'
  import { ElMessage, ElMessageBox } from 'element-plus'
  
  const searchQuery = ref('')
  const dialogVisible = ref(false)
  const isEditing = ref(false)
  const dialogTitle = ref('')
  
  const teachingForm = ref({
    id: '',
    title: '',
    type: '',
    tags: [],
    duration: 30,
    content: ''
  })
  
  const formRef = ref(null)
  
  const rules = {
    title: [
      { required: true, message: '请输入课程名称', trigger: 'blur' },
      { min: 2, max: 50, message: '长度在 2 到 50 个字符', trigger: 'blur' }
    ],
    type: [
      { required: true, message: '请选择课程类型', trigger: 'change' }
    ],
    duration: [
      { required: true, message: '请输入课程时长', trigger: 'blur' },
      { type: 'number', min: 1, max: 120, message: '时长在 1 到 120 分钟之间', trigger: 'blur' }
    ],
    content: [
      { required: true, message: '请输入教案内容', trigger: 'blur' },
      { min: 10, message: '内容不能少于 10 个字符', trigger: 'blur' }
    ]
  }
  
  // 示例数据
  const teachingList = ref([
    {
      id: 1,
      title: '基础体能训练',
      type: '普通',
      tags: ['小班', '室内'],
      duration: 20,
      content: '1. 热身运动（5分钟）\n2. 基础体能训练（10分钟）\n3. 放松运动（5分钟）'
    },
    {
      id: 2,
      title: '足球基础课程',
      type: '足球',
      tags: ['大班', '室内'],
      duration: 45,
      content: '1. 基本足球技巧训练\n2. 团队配合练习\n3. 实战演练'
    },
    {
      id: 3,
      title: '武术入门课',
      type: '武术',
      tags: ['小班'],
      duration: 30,
      content: '1. 基本站姿练习\n2. 基础拳法训练\n3. 套路学习'
    }
  ])
  
  const filteredList = computed(() => {
    return teachingList.value.filter(item =>
      item.title.toLowerCase().includes(searchQuery.value.toLowerCase())
    )
  })
  
  const handleViewEdit = (item) => {
    dialogTitle.value = '查看教案'
    isEditing.value = false
    teachingForm.value = JSON.parse(JSON.stringify(item))  // 深拷贝确保数据独立
    dialogVisible.value = true
  }
  
  const startEditing = () => {
    isEditing.value = true
    dialogTitle.value = '编辑教案'
  }
  
  const handleDialogClose = () => {
    if (formRef.value) {
      formRef.value.resetFields()
    }
    dialogVisible.value = false
    isEditing.value = false
    teachingForm.value = {
      id: '',
      title: '',
      type: '',
      tags: [],
      duration: 30,
      content: ''
    }
  }
  
  const handleAdd = () => {
    dialogTitle.value = '新增教案'
    isEditing.value = true
    dialogVisible.value = true
    if (formRef.value) {
      formRef.value.resetFields()
    }
    teachingForm.value = {
      id: Date.now(),
      title: '',
      type: '',
      tags: [],
      duration: 30,
      content: ''
    }
  }
  
  const handleSave = async () => {
    if (!formRef.value) return
    
    try {
      await formRef.value.validate()
      
      // 更新列表数据
      const index = teachingList.value.findIndex(item => item.id === teachingForm.value.id)
      if (index > -1) {
        teachingList.value[index] = { ...teachingForm.value }
      } else {
        teachingList.value.push({ ...teachingForm.value })
      }
      
      ElMessage.success('保存成功')
      dialogVisible.value = false
      isEditing.value = false
    } catch (error) {
      console.error('表单验证失败:', error)
      return false
    }
  }
  
  const handleSearch = () => {
    // 搜索逻辑已通过 computed 属性实现
    console.log('搜索关键词:', searchQuery.value)
  }
  
  const getTagType = (tag) => {
    const types = {
      '普通': '',
      '小班': 'success',
      '大班': 'warning',
      '室内': 'info'
    }
    return types[tag] || ''
  }
  
  // 添加删除相关的状态
  const deleteDialogVisible = ref(false)
  const currentDeleteId = ref(null)
  
  // 处理下拉菜单命令
  const handleCommand = (command, item) => {
    switch (command) {
      case 'view':
        handleViewEdit(item)
        break
      case 'edit':
        handleViewEdit(item)
        startEditing()
        break
      case 'delete':
        currentDeleteId.value = item.id
        deleteDialogVisible.value = true
        break
    }
  }
  
  // 确认删除
  const confirmDelete = async () => {
    try {
      const index = teachingList.value.findIndex(item => item.id === currentDeleteId.value)
      if (index > -1) {
        teachingList.value.splice(index, 1)
      }
      
      ElMessage.success('删除成功')
      deleteDialogVisible.value = false
      currentDeleteId.value = null
    } catch (error) {
      ElMessage.error('删除失败：' + error.message)
    }
  }
  </script>
  
  <style lang="scss" scoped>
  .teaching-container {
    padding: 20px;
  
    .teaching-header {
      margin-bottom: 20px;
    }
  
    .teaching-content {
      .teaching-card {
        margin-bottom: 20px;
        cursor: pointer;
        transition: all 0.3s;
  
        &:hover {
          transform: translateY(-5px);
          box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
        }
  
        .card-header {
          display: flex;
          justify-content: space-between;
          align-items: center;
          margin-bottom: 10px;
  
          .title {
            font-weight: bold;
            font-size: 16px;
          }
  
          .operations {
            display: flex;
            align-items: center;
            gap: 8px;
  
            .more-icon {
              cursor: pointer;
              padding: 4px;
              border-radius: 4px;
              transition: all 0.3s;
  
              &:hover {
                background-color: #f5f7fa;
              }
            }
          }
        }
  
        .card-tags {
          margin-bottom: 10px;
  
          .tag {
            margin-right: 5px;
            margin-bottom: 5px;
          }
        }
      }
    }
  
    :deep(.el-input__inner) {
      color: #333;
    }
  
    :deep(.el-textarea__inner) {
      color: #333;
    }
  }
  
  .dialog-footer {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
  }
  </style> 
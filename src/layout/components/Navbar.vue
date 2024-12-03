<template>
  <div class="navbar">
    <div class="right-menu">
      <el-dropdown class="avatar-container" trigger="click">
        <div class="avatar-wrapper">
          <el-avatar
            :size="32"
            :src="userInfo.avatar"
            @error="handleAvatarError"
          >
            {{ userInfo.name ? userInfo.name.charAt(0).toUpperCase() : 'U' }}
          </el-avatar>
          <span class="user-name">{{ userInfo.name }}</span>
          <el-icon class="el-icon--right"><CaretBottom /></el-icon>
        </div>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item @click="handleProfile">个人中心</el-dropdown-item>
            <el-dropdown-item divided @click="handleLogout">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/store/modules/user'
import { CaretBottom } from '@element-plus/icons-vue'
import defaultAvatar from '@/assets/images/user.jpg'
import { ElMessage } from 'element-plus'

const router = useRouter()
const userStore = useUserStore()

const userInfo = computed(() => ({
  name: userStore.name,
  avatar: userStore.avatar || defaultAvatar
}))

const handleAvatarError = () => {
  userStore.avatar = defaultAvatar
}

const handleProfile = () => {
  router.push('/profile')
}

const handleLogout = async () => {
  try {
    await userStore.logout()
    ElMessage.success('退出登录成功')
  } catch (error) {
    console.error('Logout error:', error)
    ElMessage.error('退出登录失败')
  }
}
</script>

<style lang="scss" scoped>
.navbar {
  height: 60px;
  display: flex;
  justify-content: flex-end;
  align-items: center;
  padding: 0 20px;
  
  .right-menu {
    .avatar-container {
      .avatar-wrapper {
        display: flex;
        align-items: center;
        cursor: pointer;
        padding: 0 8px;
        
        .el-avatar {
          margin-right: 8px;
          background-color: #fff;
          border: 1px solid #dcdfe6;
          
          --el-avatar-size: 32px;
        }
        
        .user-name {
          font-size: 14px;
          color: #606266;
        }

        &:hover {
          background: rgba(0, 0, 0, 0.025);
        }
      }
    }
  }
}
</style>

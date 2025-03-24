<template>
  <div class="navbar">
    <div class="left-menu">
      <div class="logo-container">
        <img src="@/assets/images/logo.png" alt="ISTM Logo">
      </div>
      <div class="title">
        <h1>ISTM</h1>
        <p>Interactive Sports Teaching Mentor</p>
      </div>
      <!-- <div class="subtitle">
        ——AI助力体育师范生教学能力提升新范式
      </div> -->
    </div>

    <div class="center-menu">
      <el-menu 
        mode="horizontal" 
        :default-active="activeMenu"
        class="menu-items"
        @select="handleSelect"
      >
        <el-menu-item index="course">
          <span class="menu-text">课程管理</span>
          <div class="active-indicator"></div>
        </el-menu-item>
        <el-menu-item index="materials">
          <span class="menu-text">精选教案</span>
          <div class="active-indicator"></div>
        </el-menu-item>
        <el-menu-item index="more">
          <el-dropdown trigger="click">
            <span class="menu-text">更多</span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="goToPath('/guide')">使用建议</el-dropdown-item>
                <el-dropdown-item @click="goToPath('/settings')">系统设置</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
          <div class="active-indicator"></div>
        </el-menu-item>
      </el-menu>
    </div>

    <div class="right-menu">
      <el-dropdown>
        <div class="avatar-container">
          <img :src="userInfo.avatar" class="user-avatar" @error="handleAvatarError">
          <span class="user-name">{{ userInfo.name }}</span>
        </div>
        <template #dropdown>
          <el-dropdown-menu>
            <el-dropdown-item @click="handleLogout">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </template>
      </el-dropdown>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { useUserStore } from '@/store/modules/user'
import defaultAvatar from '@/assets/images/user.jpg'
import { ElMessage, ElMessageBox } from 'element-plus'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

const userInfo = computed(() => ({
  name: userStore.name,
  avatar: userStore.avatar || defaultAvatar
}))

const handleAvatarError = () => {
  userStore.avatar = defaultAvatar
}

const handleLogout = async () => {
  try {
    await ElMessageBox.confirm(
      '确定要退出系统吗？',
      '提示',
      {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    await userStore.logout()
    router.push('/login')
    ElMessage.success('退出成功')
  } catch (error) {
    if (error !== 'cancel') {
      console.error('Logout error:', error)
      ElMessage.error('退出失败')
    }
  }
}

// 计算当前激活的菜单项
const activeMenu = computed(() => {
  const path = route.path
  if (path.includes('/course')) return 'course'
  if (path.includes('/materials')) return 'materials'
  return ''
})

// 处理菜单选择
const handleSelect = (key) => {
  switch (key) {
    case 'course':
      router.push('/classroom/list')
      break
    case 'materials':
      router.push('/materials')
      break
  }
}

// 跳转到指定路径
const goToPath = (path) => {
  router.push(path)
}
</script>

<style lang="scss" scoped>
@use '@/assets/styles/variables' as *;

.navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  height: $navbar-height;
  display: flex;
  align-items: center;
  padding: 0;
  background: $navbar-bg;
  box-shadow: 0 1px 4px rgba(0,0,0,.1);
  z-index: 1000;

  .left-menu {
    display: flex;
    align-items: center;
    margin-left: 10px;
    
    .logo-container {
      img {
        margin-top: -15px;
        margin-right: -10px;
        width: 100px;
        height: 150px;
      }

    }

    .title {
      margin-left: 5px;
      
      h1 {
        font-size: 28px;
        font-weight: bold;
        margin: 0;
        color: $navbar-title-color;
        font-family: $font-family-special;
        letter-spacing: 1px;
      }

      p {
        font-size: 14px;
        margin: 0;
        color: $navbar-subtitle-color;
        font-family: $font-family-special;
        letter-spacing: 0.5px;
      }
    }

    .subtitle {
      margin-left: 15px;
      font-size: 14px;
      color: $navbar-subtitle-color;
      font-family: $font-family-chinese;
      letter-spacing: 0.5px;
      position: relative;
      padding-left: 15px;
      
      &::before {
        content: '';
        position: absolute;
        left: 0;
        top: 50%;
        transform: translateY(-50%);
        width: 1px;
        height: 20px;
        background-color: $navbar-border;
      }
    }
  }

  .center-menu {
    flex: 1;
    display: flex;
    margin-left: 100px;

    :deep(.el-menu) {
      border: none;
      background: transparent;
      display: flex;
      gap: 40px;
    }

    :deep(.el-menu-item) {
      font-size: 16px;
      height: $navbar-height;
      line-height: $navbar-height;
      padding: 0 20px;
      position: relative;
      
      .menu-text {
        color: $navbar-title-color;
        font-weight: 500;
        font-size: 18px;
        transition: color 0.3s ease;
      }

      .active-indicator {
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 0;
        height: 3px;
        background-color: $primary-green;
        transition: width 0.3s ease;
      }
      
      &.is-active {
        .menu-text {
          color: $primary-green;
        }
        
        .active-indicator {
          width: 100%;
        }
      }

      &:hover {
        background-color: transparent;
        
        .menu-text {
          color: $primary-green;
        }
      }
    }
  }

  .right-menu {
    .avatar-container {
      display: flex;
      align-items: center;
      cursor: pointer;
      padding: 0 12px;
      border-radius: 4px;
      transition: background-color 0.3s ease;

      &:hover {
        background-color: rgba(0, 0, 0, 0.02);
      }

      .user-avatar {
        width: $navbar-logo-size;
        height: $navbar-logo-size;
        border-radius: 50%;
        margin-right: 10px;
        border: 1px solid $navbar-border;
      }

      .user-name {
        font-size: $font-size-base;
        color: $navbar-title-color;
        font-weight: 500;
      }
    }
  }
}
</style>

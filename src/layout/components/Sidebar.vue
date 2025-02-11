<template>
  <div class="sidebar-container">
    <div class="logo">
      <img src="@/assets/logo/istm-logo.png" alt="ISTM Logo">
      <h1>ISTM</h1>
    </div>
    
    <el-menu
      :default-active="activeMenu"
      :collapse="isCollapse"
      background-color="#fff"
      text-color="#333"
      active-text-color="#95d475"
      class="sidebar-menu"
      router
    >
      <el-menu-item index="/dashboard">
        <el-icon><Platform /></el-icon>
        <template #title>
          <span class="menu-title">平台资讯</span>
        </template>
      </el-menu-item>

      <el-menu-item index="/classroom">
        <el-icon><School /></el-icon>
        <template #title>
          <span class="menu-title">AI课堂</span>
        </template>
      </el-menu-item>

      <el-menu-item index="/history">
        <el-icon><Timer /></el-icon>
        <template #title>
          <span class="menu-title">历史课堂</span>
        </template>
      </el-menu-item>

      <el-menu-item index="/guide">
        <el-icon><Guide /></el-icon>
        <template #title>
          <span class="menu-title">使用建议</span>
        </template>
      </el-menu-item>

      <el-menu-item index="/settings">
        <el-icon><Setting /></el-icon>
        <template #title>
          <span class="menu-title">系统设置</span>
        </template>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { Platform, School, Timer, Guide, Setting } from '@element-plus/icons-vue'

const route = useRoute()
const activeMenu = computed(() => route.path)
const isCollapse = ref(false)
</script>

<style lang="scss" scoped>
.sidebar-container {
  height: 100%;
  background-color: #fff;
  border-right: 1px solid #e6e6e6;
  transition: width 0.3s;
  overflow-y: auto;
  
  // 隐藏滚动条但保持功能
  &::-webkit-scrollbar {
    width: 0;
    height: 0;
  }

  .logo {
    height: 60px;
    padding: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #2b2f3a;
    
    img {
      height: 32px;
      margin-right: 8px;
    }
    
    h1 {
      color: #fff;
      font-size: 18px;
      margin: 0;
    }
  }
  
  .sidebar-menu {
    border: none;
    padding-top: 75px; // 为顶部导航栏留出空间

    :deep(.el-menu-item) {
      height: 56px;
      line-height: 56px;
      padding: 0 20px;
      margin: 4px 0;
      
      .el-icon {
        font-size: 18px;
        margin-right: 12px;
        color: #666;
      }

      .menu-title {
        font-size: 16px;
        font-weight: 500;
        color: #333;
      }

      &:hover {
        background-color: #f5f7fa;
        
        .el-icon,
        .menu-title {
          color: #95d475;
        }
      }

      &.is-active {
        background-color: #f0f9eb;
        
        &::before {
          content: '';
          position: absolute;
          left: 0;
          top: 0;
          width: 4px;
          height: 100%;
          background-color: #95d475;
        }

        .el-icon,
        .menu-title {
          color: #95d475;
        }
      }
    }
  }
}
</style>

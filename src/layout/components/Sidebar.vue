<template>
  <div class="sidebar-container">
    <div class="logo">
      <img src="@/assets/logo/istm-logo.png" alt="ISTM Logo">
      <h1>ISTM</h1>
    </div>
    
    <el-menu
      :default-active="activeMenu"
      background-color="#304156"
      text-color="#bfcbd9"
      active-text-color="#409EFF"
      :unique-opened="true"
      :collapse-transition="false"
      mode="vertical"
      router
    >
      <el-menu-item index="/dashboard">
        <el-icon><HomeFilled /></el-icon>
        <template #title>首页</template>
      </el-menu-item>
      
      <el-sub-menu index="/teaching">
        <template #title>
          <el-icon><Document /></el-icon>
          <span>教学管理</span>
        </template>
        <el-menu-item index="/teaching/management">教案管理</el-menu-item>
      </el-sub-menu>
      
      <el-menu-item index="/students">
        <el-icon><User /></el-icon>
        <template #title>学生管理</template>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { HomeFilled, Document, User } from '@element-plus/icons-vue'
import { useRoute } from 'vue-router'

const route = useRoute()
const activeMenu = ref(route.path)
</script>

<style lang="scss" scoped>
.sidebar-container {
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
  
  .el-menu {
    border-right: none;
  }
}
</style>

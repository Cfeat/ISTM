<template>
  <div class="app-wrapper">
    <Sidebar class="sidebar-container" />
    <div class="main-container">
      <Navbar />
      <div class="app-main">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script setup>
import Navbar from './components/Navbar.vue'
import Sidebar from './components/Sidebar.vue'
</script>

<style lang="scss" scoped>
.app-wrapper {
  position: relative;
  height: 100vh;
  width: 100%;

  .sidebar-container {
    position: fixed;
    top: 0;
    left: 0;
    width: 210px;
    height: 100%;
    z-index: 999;
  }

  .main-container {
    min-height: 100%;
    margin-left: 210px;
    position: relative;
    
    .app-main {
      padding-top: 75px; // 为固定定位的导航栏留出空间
      min-height: calc(100vh - 75px);
      width: 100%;
      position: relative;
      overflow: hidden;
      background-color: #f0f2f5;
    }
  }
}
</style>

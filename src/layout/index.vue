<template>
  <div class="app-wrapper">
    <el-container>
      <el-aside width="200px">
        <sidebar />
      </el-aside>
      
      <el-container>
        <el-header height="60px">
          <navbar />
        </el-header>
        
        <el-main>
          <app-main />
        </el-main>
      </el-container>
    </el-container>
  </div>
</template>

<script setup>
import Navbar from './components/Navbar.vue'
import Sidebar from './components/Sidebar.vue'
import AppMain from './components/AppMain.vue'
</script>

<style lang="scss" scoped>
.app-wrapper {
  height: 100vh;
  
  .el-aside {
    background-color: #304156;
    height: 100vh;
    overflow-x: hidden;
    overflow-y: auto;
  }

  .el-header {
    background-color: #fff;
    border-bottom: 1px solid #dcdfe6;
    padding: 0;
  }

  .el-main {
    background-color: #f0f2f5;
    padding: 20px;
  }
}
</style>

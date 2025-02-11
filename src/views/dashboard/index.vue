<template>
  <div class="dashboard-container">
    <div class="grid-layout">
      <!-- 左上角区域：快速创建按钮和公告 -->
      <div class="top-left">
        <el-button class="create-button" @click="createAIClassroom">
          <el-icon><VideoPlay /></el-icon>
          <span>快速创建</span>
          <span>AI课堂</span>
        </el-button>

        <div class="announcement">
          <div class="version-header">
            <!-- <div class="logo-wrapper">
              <img src="@/assets/images/logo.png" alt="Logo" />
            </div> -->
            <div class="version-title">
              <h3>ISTM 平台更新公告</h3>
              <p>Version 1.2.0 | 2025年2月更新</p>
            </div>
          </div>
          
          <div class="whats-new">
            <p class="section-title">最新动态：</p>
            <div class="update-content">
              <p>- 新功能上线：</p>
              <ul>
                <li>* AI课堂实时反馈系统；</li>
                <li>* 教学动作智能纠正；</li>
                <li>* 课堂语音助手；</li>
                <li>* 教案智能生成。</li>
              </ul>
              <p>- 系统优化：</p>
              <ul>
                <li>* 提升AI识别准确率；</li>
                <li>* 优化课堂互动体验；</li>
                <li>* 新增多种教学模板；</li>
                <li>* 完善数据分析报告。</li>
              </ul>
            </div>
          </div>
        </div>
      </div>

      <!-- 右上角区域：教师形象幻灯片 -->
      <div class="top-right">
        <el-carousel 
          height="100%" 
          :interval="3000"  
          arrow="hover" 
          indicator-position="inside"
        >
          <el-carousel-item v-for="(image, index) in teacherImages" :key="index">
            <img :src="image.url" :alt="image.alt" class="teacher-image" />
          </el-carousel-item>
        </el-carousel>
      </div>

      <!-- 左下角区域：AI教学形象 -->
      <div class="bottom-left">
        <img src="@/assets/images/dashboard/teacher2.png" alt="AI Teaching" class="ai-image" />
      </div>

      <!-- 右下角区域：ISTM水印 -->
      <div class="bottom-right">
        <div class="watermark">ISTM</div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { VideoPlay } from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// 幻灯片图片数组
const teacherImages = [
  {
    url: '/src/assets/images/dashboard/teacher1.png',
    alt: 'Teacher 1'
  },
  {
    url: '/src/assets/images/dashboard/teacher2.png',
    alt: 'Teacher 2'
  },
  {
    url: '/src/assets/images/dashboard/teacher3.png',
    alt: 'Teacher 3'
  }
]

const createAIClassroom = () => {
  router.push('/classroom/create')
}
</script>

<style lang="scss" scoped>
.dashboard-container {
  min-height: calc(100vh - 70px); // 减去导航栏高度
  padding: 20px;
  height: calc(100vh - 95px);

  .grid-layout {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: 60% 40%;
    gap: 24px;
    height: 100%;

    > div {
      position: relative;
      overflow: hidden;
    }

    .top-left {
      .create-button {
        width: 80%;
        height: 90px;
        background: #95d475;
        border: none;
        border-radius: 24px;
        color: white;
        font-size: 16px;
        margin-bottom: 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        
        .el-icon {
          font-size: 24px;
          margin-right: 8px;
        }

        span {
          display: block;
          line-height: 1.4;
        }

        &:hover {
          background: #85c665;
        }
      }

      .announcement {
        height: calc(100% - 110px);
        overflow-y: auto;
        padding-right: 10px;

        &::-webkit-scrollbar {
          width: 6px;
        }

        &::-webkit-scrollbar-thumb {
          background-color: rgba(149, 212, 117, 0.3);
          border-radius: 3px;
        }

        &::-webkit-scrollbar-track {
          background-color: transparent;
        }

        .version-header {
          margin-bottom: 24px;
        }


        .whats-new {
          .section-title {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 16px;
          }

          .update-content {
            p {
              margin-bottom: 12px;
            }

            ul {
              margin-bottom: 20px;

              li {
                margin-bottom: 8px;
                line-height: 1.6;
              }
            }
          }
        }
      }
    }

    .top-right {
      :deep(.el-carousel) {
        width: 100%;
        height: 100%;

        .el-carousel__container {
          height: 100%;
        }

        .el-carousel__item {
          display: flex;
          align-items: center;
          justify-content: center;
          
          .teacher-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 50px;
          }
        }

        // 自定义指示器样式
        .el-carousel__indicators {
          bottom: 20px;

          .el-carousel__button {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: rgba(255, 255, 255, 0.6);

            &:hover {
              background-color: rgba(255, 255, 255, 0.8);
            }
          }
        }

        // 自定义箭头样式
        .el-carousel__arrow {
          background-color: rgba(149, 212, 117, 0.3);
          border-radius: 50%;
          
          &:hover {
            background-color: rgba(149, 212, 117, 0.5);
          }
        }
      }
    }

    .bottom-left {
      display: flex;
      align-items: flex-end;
      justify-content: center;

      .ai-image {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center top;
        border-radius: 50px;
        margin-top: -40px;
      }
    }

    .bottom-right {
      display: flex;
      align-items: center;
      justify-content: center;

      .watermark {
        font-size: 300px;
        font-weight: bold;
        color: rgba(92, 225, 25, 0.15);
        font-family: 'Bauhaus 93', sans-serif;
        transform: none;
        letter-spacing: 4px;
      }
    }
  }
}
</style>

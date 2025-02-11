import { createApp } from 'vue'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'
import '@/assets/styles/index.scss'
import { setupRouterGuard } from './router/permission'

// 判断是否为开发环境
if (import.meta.env.MODE === 'development') {
  import('@/mock')
}

const app = createApp(App)

app.use(ElementPlus)
app.use(createPinia())
app.use(router)

// 确保在使用 router 之后设置路由守卫
setupRouterGuard(router)

app.mount('#app')

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import { createPinia } from 'pinia'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import 'virtual:svg-icons-register'

// 自定义样式
import '@/assets/styles/index.scss'

// 组件
import SvgIcon from '@/components/SvgIcon/index.vue'
import Pagination from '@/components/Pagination/index.vue'

const app = createApp(App)

// 全局组件注册
app.component('svg-icon', SvgIcon)
app.component('Pagination', Pagination)

app.use(createPinia())
app.use(router)
app.use(ElementPlus)

app.mount('#app')

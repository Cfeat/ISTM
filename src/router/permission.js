import router from './index'
import { useUserStore } from '@/store/modules/user'
import { getToken } from '@/utils/auth'
import { ElMessage } from 'element-plus'

const whiteList = ['/login'] // 白名单

router.beforeEach(async (to, from, next) => {
  const hasToken = getToken()
  
  if (hasToken) {
    if (to.path === '/login') {
      next({ path: '/' })
    } else {
      const userStore = useUserStore()
      if (!userStore.name) {
        try {
          await userStore.getInfo()
          next()
        } catch (error) {
          await userStore.logout()
          ElMessage.error(error.message || '获取用户信息失败')
          next('/login')
        }
      } else {
        next()
      }
    }
  } else {
    if (whiteList.indexOf(to.path) !== -1) {
      next()
    } else {
      next('/login')
    }
  }
})

import router from './index'
import { useUserStore } from '@/store/modules/user.js'
import { getToken } from '@/utils/auth'
import { ElMessage } from 'element-plus'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'

NProgress.configure({ showSpinner: false })

const whiteList = ['/login'] // 白名单

export function setupRouterGuard(router) {
router.beforeEach(async (to, from, next) => {
  NProgress.start()
  
    const hasToken = getToken()
  const userStore = useUserStore()

  if (hasToken) {
    if (to.path === '/login') {
      next({ path: '/' })
      NProgress.done()
    } else {
      const hasGetUserInfo = userStore.name
      if (hasGetUserInfo) {
        next()
      } else {
        try {
          await userStore.getInfo()
            next()
        } catch (error) {
          await userStore.resetToken()
          next(`/login?redirect=${to.path}`)
          NProgress.done()
        }
      }
    }
  } else {
    if (whiteList.indexOf(to.path) !== -1) {
      next()
    } else {
      next(`/login?redirect=${to.path}`)
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  NProgress.done()
})
}

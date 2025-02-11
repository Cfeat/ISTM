import { defineStore } from 'pinia'
import { login, logout, getInfo } from '@/api/login'
import { getToken, setToken, removeToken } from '@/utils/auth'
import { ElMessage } from 'element-plus'

export const useUserStore = defineStore('user', {
  state: () => ({
    token: getToken(),
    name: '',
    avatar: '',
    roles: []
  }),
  
  actions: {
    // 登录
    async login(userInfo) {
      try {
        const { username, password, code, uuid } = userInfo
        const res = await login({ 
          username: username.trim(), 
          password, 
          code, 
          uuid 
        })
        
        if (res.code === 200) {
          const { token } = res.data
          this.token = token
          setToken(token)
          return res
        } else {
          throw new Error(res.msg || '登录失败')
        }
      } catch (error) {
        console.error('Login failed:', error)
        throw error
      }
    },

    // 获取用户信息
    async getInfo() {
      try {
        const res = await getInfo()
        if (res.code === 200) {
          const { user } = res.data
          this.name = user.nickname
          this.avatar = user.avatar
          this.roles = user.roles
          return res.data
        } else {
          throw new Error(res.msg || '获取用户信息失败')
        }
      } catch (error) {
        console.error('Get user info failed:', error)
        throw error
      }
    },

    // 退出系统
    async logout() {
      try {
        await logout()
        this.token = ''
        this.roles = []
        this.name = ''
        this.avatar = ''
        removeToken()
        ElMessage.success('退出成功')
      } catch (error) {
        console.error('Logout failed:', error)
        throw error
      }
    },

    // 重置 token
    resetToken() {
      this.token = ''
      this.roles = []
      this.name = ''
      this.avatar = ''
      removeToken()
    }
  }
})

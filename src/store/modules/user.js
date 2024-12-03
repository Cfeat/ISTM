import { defineStore } from 'pinia'
import { login, logout, getInfo } from '@/api/login'
import { getToken, setToken, removeToken } from '@/utils/auth'

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
        const data = await login(userInfo)
        this.token = data.token
        setToken(data.token)
      } catch (error) {
        throw error
      }
    },

    // 获取用户信息
    async getInfo() {
      try {
        const data = await getInfo()
        this.name = data.name
        this.avatar = data.avatar
        this.roles = data.roles
        return data
      } catch (error) {
        throw error
      }
    },

    // 退出登录
    async logout() {
      try {
        await logout()
        this.token = ''
        this.roles = []
        this.name = ''
        this.avatar = ''
        removeToken()
      } catch (error) {
        throw error
      }
    }
  }
})

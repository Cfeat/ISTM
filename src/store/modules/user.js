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
        const res = await login(username.trim(), password, code, uuid)
        console.log('登录返回数据结构:', res)
        
        // 成功码: 200或0
        if (res.code === 200 || res.code === 0) {
          // 兼容不同的返回结构，可能token在多个位置
          let token = ''
          
          if (res.token) {
            token = res.token
          } else if (res.data && res.data.token) {
            token = res.data.token
          } else if (typeof res.data === 'string') {
            // 有些版本返回的data直接就是token字符串
            token = res.data
          }
          
          if (!token) {
            console.warn('响应中未找到token:', res)
          }
          
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
        console.log('获取用户信息返回:', res)
        
        if (res.code === 200 || res.code === 0) {
          // 兼容多种可能的数据结构
          let userData = {}
          
          if (res.user) {
            userData = res.user
          } else if (res.data && res.data.user) {
            userData = res.data.user
          } else if (res.data) {
            userData = res.data
          }
          
          // 提取用户名、头像和角色信息
          this.name = userData.userName || userData.nickName || userData.username || userData.name || 'Unknown'
          this.avatar = userData.avatar || ''
          
          // 处理角色数据
          if (userData.roles) {
            this.roles = userData.roles
          } else if (userData.roleIds) {
            this.roles = userData.roleIds.map(id => ({ roleId: id }))
          } else {
            this.roles = ['default']
          }
          
          return res
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

import { createRouter, createWebHistory } from 'vue-router'

export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index.vue'),
    hidden: true
  },
  {
    path: '/',
    component: () => import('@/layout/index.vue'),
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        component: () => import('@/views/dashboard/index.vue'),
        name: 'Dashboard',
        meta: { title: '首页', icon: 'dashboard' }
      },
      {
        path: '/teaching',
        component: () => import('@/views/teaching/index.vue'),
        name: 'Teaching',
        meta: { title: '教学管理', icon: 'document' },
        redirect: '/teaching/management',
        children: [
          {
            path: 'management',
            component: () => import('@/views/teaching/management.vue'),
            name: 'TeachingManagement',
            meta: { title: '教案管理' }
          }
        ]
      },
      {
        path: 'students',
        component: () => import('@/views/students/index.vue'),
        name: 'Students',
        meta: { title: '学生管理', icon: 'user' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes: constantRoutes
})

export default router

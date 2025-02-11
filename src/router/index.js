import { createRouter, createWebHistory } from 'vue-router'
import Layout from '@/layout/index.vue'

export const constantRoutes = [
  {
    path: '/redirect',
    component: Layout,
    hidden: true,
    children: [
      {
        path: '/redirect/:path(.*)',
        component: () => import('@/views/redirect/index.vue')
      }
    ]
  },
  {
    path: '/login',
    component: () => import('@/views/login/index.vue'),
    hidden: true
  },
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: () => import('@/views/dashboard/index.vue'),
        meta: { title: '平台资讯', icon: 'Platform' }
      }
    ]
  },
  {
    path: '/classroom',
    component: Layout,
    redirect: '/classroom/list',
    children: [
      {
        path: 'list',
        name: 'ClassroomList',
        component: () => import('@/views/classroom/list.vue'),
        meta: { title: 'AI课堂', icon: 'School' }
      },
      {
        path: 'create',
        name: 'ClassroomCreate',
        component: () => import('@/views/classroom/create.vue'),
        meta: { title: '创建AI课堂' },
        hidden: true
      },
      {
        path: 'detail/:id',
        name: 'ClassroomDetail',
        component: () => import('@/views/classroom/detail.vue'),
        meta: { title: 'AI课堂详情' },
        hidden: true
      }
    ]
  },
  {
    path: '/history',
    component: Layout,
    children: [
      {
        path: '',
        name: 'History',
        component: () => import('@/views/history/index.vue'),
        meta: { title: '历史课堂', icon: 'Timer' }
      }
    ]
  },
  {
    path: '/guide',
    component: Layout,
    children: [
      {
        path: '',
        name: 'Guide',
        component: () => import('@/views/guide/index.vue'),
        meta: { title: '使用建议', icon: 'Guide' }
      }
    ]
  },
  {
    path: '/settings',
    component: Layout,
    children: [
      {
        path: '',
        name: 'Settings',
        component: () => import('@/views/settings/index.vue'),
        meta: { title: '系统设置', icon: 'Setting' }
      }
    ]
  },
  {
    path: '/course',
    component: Layout,
    redirect: '/course/list',
    meta: { title: '课程管理', icon: 'Education' },
    children: [
      {
        path: 'list',
        name: 'CourseList',
        component: () => import('@/views/course/list.vue'),
        meta: { title: '课程列表' }
      },
      {
        path: 'detail/:id',
        name: 'CourseDetail',
        component: () => import('@/views/course/detail.vue'),
        meta: { title: '课程详情' },
        hidden: true
      }
    ]
  },
  {
    path: '/materials',
    component: Layout,
    children: [
      {
        path: '',
        name: 'Materials',
        component: () => import('@/views/materials/index.vue'),
        meta: { title: '精选教案', icon: 'Document' }
      }
    ]
  }
]

// 动态路由
export const asyncRoutes = [
  {
    path: '/dashboard',
    component: Layout,
    redirect: '/dashboard/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/dashboard/index.vue'),
        name: 'Dashboard',
        meta: { title: '平台资讯', icon: 'dashboard', affix: true }
      }
    ]
  },
  {
    path: '/history',
    component: Layout,
    redirect: '/history/index',
    children: [
      {
        path: 'index',
        component: () => import('@/views/history/index.vue'),
        name: 'History',
        meta: { title: '历史课堂', icon: 'history' }
      }
    ]
  },
  {
    path: '/classroom',
    component: Layout,
    redirect: '/classroom/list',
    meta: { title: 'AI课堂', icon: 'School' },
    children: [
      {
        path: 'list',
        name: 'ClassroomList',
        component: () => import('@/views/classroom/list.vue'),
        meta: { title: 'AI课堂列表' }
      },
      {
        path: 'create',
        name: 'ClassroomCreate',
        component: () => import('@/views/classroom/create.vue'),
        meta: { title: '创建AI课堂' }
      }
    ]
  },
  {
    path: '/guide',
    component: Layout,
    children: [
      {
        path: '',
        name: 'Guide',
        component: () => import('@/views/guide/index.vue'),
        meta: { title: '使用建议', icon: 'Guide' }
      }
    ]
  },
  {
    path: '/settings',
    component: Layout,
    children: [
      {
        path: '',
        name: 'Settings',
        component: () => import('@/views/settings/index.vue'),
        meta: { title: '系统设置', icon: 'Setting' }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes: constantRoutes,
  scrollBehavior: () => ({ top: 0 })
})

export default router
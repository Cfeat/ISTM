import request from '@/utils/request'

// 查询课堂列表
export function listClassroom(query) {
  return request({
    url: '/system/class/list',
    method: 'get',
    params: query
  })
}

// 查询课堂详细
export function getClassroom(classroomId) {
  if (!classroomId) {
    console.error('getClassroom: classroomId is undefined or null');
    return Promise.reject(new Error('课堂ID不能为空'));
  }
  
  return request({
    url: '/system/class/' + classroomId,
    method: 'get'
  })
}

// 新增课堂
export function addClassroom(data) {
  // 确保删除classId字段，避免后端接收到undefined
  if (data) {
    const submitData = { 
      className: data.className,
      classType: data.classType,
      studentCount: data.studentCount,
      duration: data.duration,
      // 映射教学目标和教学过程为后端字段
      classPurpose: data.classDesc,  // 教学目标
      classProcess: data.planInfo,   // 教学过程
      remark: data.classDesc         // 同时复制到备注字段以兼容
    };
    
    console.log('映射后的提交数据:', submitData);
    
    return request({
      url: '/system/class',
      method: 'post',
      data: submitData
    });
  }
  
  return request({
    url: '/system/class',
    method: 'post',
    data: data
  })
}

// 修改课堂
export function updateClassroom(data) {
  // 确保字段映射正确
  if (data) {
    const submitData = {
      classId: data.classId,
      className: data.className,
      classType: data.classType,
      studentCount: data.studentCount,
      duration: data.duration,
      // 映射教学目标和教学过程为后端字段
      classPurpose: data.classDesc,  // 教学目标
      classProcess: data.planInfo,   // 教学过程
      remark: data.classDesc         // 同时复制到备注字段以兼容
    };
    
    console.log('映射后的更新数据:', submitData);
    
    return request({
      url: '/system/class',
      method: 'put',
      data: submitData
    });
  }
  
  return request({
    url: '/system/class',
    method: 'put',
    data: data
  })
}

// 删除课堂
export function delClassroom(classroomId) {
  return request({
    url: '/system/class/' + classroomId,
    method: 'delete'
  })
}

// 开始上课
export function startClassroom(classroomId) {
  if (!classroomId) {
    console.error('startClassroom: classroomId is undefined or null');
    return Promise.reject(new Error('课堂ID不能为空'));
  }
  
  // 检查是否为开发环境或已提供实际API
  if (import.meta.env.MODE === 'development' && !import.meta.env.VITE_USE_ACTUAL_API) {
    console.log('使用模拟的开始上课接口');
    // 返回模拟数据
    return Promise.resolve({
      code: 200,
      msg: '操作成功',
      data: {
        classId: classroomId,
        status: 1
      }
    });
  }
  
  return request({
    url: '/system/class/start/' + classroomId,
    method: 'put'
  })
}

// 获取虚拟学生列表
export function getVirtualStudents(classroomId) {
  if (!classroomId) {
    console.error('getVirtualStudents: classroomId is undefined or null');
    return Promise.reject(new Error('课堂ID不能为空'));
  }
  
  // 检查是否为开发环境或已提供实际API
  if (import.meta.env.MODE === 'development' && !import.meta.env.VITE_USE_ACTUAL_API) {
    console.log('使用模拟的虚拟学生接口');
    // 生成随机的虚拟学生数据
    const students = [];
    for (let i = 0; i < 10; i++) {
      students.push({
        id: i + 1,
        name: `学生${i + 1}`,
        gender: i % 2 === 0 ? '男' : '女',
        avatar: `https://randomuser.me/api/portraits/${i % 2 === 0 ? 'men' : 'women'}/${i + 1}.jpg`
      });
    }
    
    return Promise.resolve({
      code: 200,
      msg: '操作成功',
      data: students
    });
  }
  
  return request({
    url: '/system/class/students/' + classroomId,
    method: 'get'
  })
}

// 发送教师指令
export function sendTeacherCommand(data) {
  return request({
    url: '/system/class/command',
    method: 'post',
    data: data
  })
}

// 获取错误案例列表
export function getErrorCases(classroomId) {
  return request({
    url: '/system/class/error-cases/' + classroomId,
    method: 'get'
  })
}

// 更新学生数量
export function updateStudentCount(data) {
  return request({
    url: '/system/class/student-count',
    method: 'put',
    data: data
  })
}

// 上传教案文件
export function uploadTeachingPlan(data) {
  return request({
    url: '/system/class/upload',
    method: 'post',
    headers: {
      'Content-Type': 'multipart/form-data'
    },
    data
  })
}

// 获取课程类型列表
export function getCourseTypes() {
  return request({
    url: '/system/dict/data/type/sys_class_type',
    method: 'get'
  })
} 
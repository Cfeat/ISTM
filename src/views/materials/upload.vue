<template>
  <div class="upload-container">
    <div class="header-section">
      <h2>上传教案</h2>
      <el-button @click="goBack">返回</el-button>
    </div>

    <el-card>
      <el-form ref="form" :model="formData" :rules="rules" label-width="100px">
        <el-form-item label="教案标题" prop="title">
          <el-input v-model="formData.title" placeholder="请输入教案标题"></el-input>
        </el-form-item>
        
        <el-form-item label="教案类型" prop="planType">
          <el-select v-model="formData.planType" placeholder="请选择教案类型">
            <el-option label="篮球" value="篮球"></el-option>
            <el-option label="足球" value="足球"></el-option>
            <el-option label="排球" value="排球"></el-option>
            <el-option label="田径" value="田径"></el-option>
            <el-option label="体操" value="体操"></el-option>
          </el-select>
        </el-form-item>
        
        <el-form-item label="教案内容" prop="planDesc">
          <el-input type="textarea" v-model="formData.planDesc" rows="4" placeholder="请输入教案内容简介"></el-input>
        </el-form-item>
        
        <el-form-item label="教学目标" prop="planPurpose">
          <el-input type="textarea" v-model="formData.planPurpose" rows="4" placeholder="请输入教学目标"></el-input>
        </el-form-item>
        
        <el-form-item label="教学过程" prop="planProcess">
          <el-input type="textarea" v-model="formData.planProcess" rows="6" placeholder="请输入教学过程"></el-input>
        </el-form-item>
        
        <el-form-item label="教案文件" prop="file">
          <el-upload
            class="upload-demo"
            :action="uploadUrl"
            :headers="headers"
            :on-success="handleUploadSuccess"
            :on-error="handleUploadError"
            :before-upload="beforeUpload"
            :file-list="fileList"
            accept=".docx,.pdf,.txt"
            :limit="1"
          >
            <el-button type="primary">选择文件</el-button>
            <template #tip>
              <div class="el-upload__tip">
                仅支持 docx, pdf, txt 格式文件，大小不超过 10MB
              </div>
            </template>
          </el-upload>
        </el-form-item>
        
        <el-form-item label="封面图片">
          <el-upload
            class="avatar-uploader"
            :action="uploadImageUrl"
            :headers="headers"
            :show-file-list="false"
            :on-success="handleAvatarSuccess"
            :before-upload="beforeAvatarUpload"
          >
            <img v-if="formData.avatar" :src="formData.avatar" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </el-form-item>
        
        <el-form-item>
          <el-button type="primary" @click="submitForm">提交</el-button>
          <el-button @click="resetForm">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, reactive } from 'vue';
import { Plus } from '@element-plus/icons-vue';
import { getToken } from '@/utils/auth';
import { ElMessage } from 'element-plus';
import { uploadTeachingPlan } from '@/api/materials';
import { useRouter } from 'vue-router';

const router = useRouter();
const form = ref(null);
const fileList = ref([]);

// 表单数据
const formData = reactive({
  title: '',
  planType: '',
  planDesc: '',
  planPurpose: '',
  planProcess: '',
  avatar: '',
  filePath: ''
});

// 表单验证规则
const rules = {
  title: [{ required: true, message: '请输入教案标题', trigger: 'blur' }],
  planType: [{ required: true, message: '请选择教案类型', trigger: 'change' }],
  planDesc: [{ required: true, message: '请输入教案内容', trigger: 'blur' }],
  planPurpose: [{ required: true, message: '请输入教学目标', trigger: 'blur' }],
  planProcess: [{ required: true, message: '请输入教学过程', trigger: 'blur' }]
};

// 上传地址
const uploadUrl = import.meta.env.VITE_APP_BASE_API + '/system/plan/upload';
const uploadImageUrl = import.meta.env.VITE_APP_BASE_API + '/common/upload';

// 请求头
const headers = {
  Authorization: 'Bearer ' + getToken()
};

// 处理文件上传成功
const handleUploadSuccess = (res) => {
  if (res.code === 200) {
    formData.filePath = res.data.url;
    ElMessage.success('文件上传成功');
  } else {
    ElMessage.error(res.msg || '上传失败');
  }
};

// 处理文件上传失败
const handleUploadError = () => {
  ElMessage.error('文件上传失败');
};

// 上传前检查
const beforeUpload = (file) => {
  const isLt10M = file.size / 1024 / 1024 < 10;
  if (!isLt10M) {
    ElMessage.error('文件大小不能超过 10MB!');
    return false;
  }
  return true;
};

// 处理头像上传成功
const handleAvatarSuccess = (res) => {
  if (res.code === 200) {
    formData.avatar = res.data.url;
  } else {
    ElMessage.error(res.msg || '上传失败');
  }
};

// 上传前检查头像
const beforeAvatarUpload = (file) => {
  const isJPG = file.type === 'image/jpeg' || file.type === 'image/png';
  const isLt2M = file.size / 1024 / 1024 < 2;

  if (!isJPG) {
    ElMessage.error('上传头像图片只能是 JPG 或 PNG 格式!');
    return false;
  }
  if (!isLt2M) {
    ElMessage.error('上传头像图片大小不能超过 2MB!');
    return false;
  }
  return true;
};

// 提交表单
const submitForm = () => {
  form.value.validate((valid) => {
    if (valid) {
      uploadTeachingPlan(formData).then(res => {
        if (res.code === 200) {
          ElMessage.success('教案提交成功');
          router.push('/materials');
        } else {
          ElMessage.error(res.msg || '提交失败');
        }
      }).catch(() => {
        ElMessage.error('提交失败');
      });
    } else {
      return false;
    }
  });
};

// 重置表单
const resetForm = () => {
  form.value.resetFields();
  formData.avatar = '';
  formData.filePath = '';
  fileList.value = [];
};

// 返回材料列表
const goBack = () => {
  router.push('/materials');
};
</script>

<style scoped>
.upload-container {
  padding: 20px;
}

.header-section {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.avatar-uploader {
  width: 178px;
  height: 178px;
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: border-color 0.3s;
}

.avatar-uploader:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}

.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>

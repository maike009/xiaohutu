<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入用户"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="点赞数" prop="likeCount">
        <el-input
          v-model="queryParams.likeCount"
          placeholder="请输入点赞数"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="帖子状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择帖子状态" clearable>
          <el-option
            v-for="dict in post_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="Search" @click="handleQuery">搜索</el-button>
        <el-button icon="Refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="Plus"
          @click="handleAdd"
          v-hasPermi="['post:post:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['post:post:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['post:post:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['post:post:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="postList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="帖子ID" align="center" prop="id" />
      <el-table-column label="用户" align="center" prop="userName" />
      <el-table-column label="用户昵称" align="center" prop="nickName" />
      <el-table-column label="发布地址" align="center" prop="addr" />
      <el-table-column label="文本内容" align="center" prop="contentText" />
      <el-table-column label="图片地址" align="center" prop="contentImage" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.contentImage" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="点赞数" align="center" prop="likeCount" />
      <el-table-column label="评论数" align="center" prop="commentCount" />
      <el-table-column label="标签" align="center" prop="tagContent" />
      <el-table-column label="是否公开" align="center">
        <template #default="scope">
          <span>{{ scope.row.isPublic === 0? '是' : '不公开' }}</span>
        </template>
      </el-table-column>
      <el-table-column label="收藏数量" align="center" prop="favoriteCount" />
      <el-table-column label="是否发布" align="center" prop="draftStatus" >
        <template #default="scope">
          <span>{{ scope.row.draftStatus === 0? '是' : '否'  }}</span>
        </template>
      </el-table-column>
      <el-table-column label="帖子状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="post_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['post:post:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['post:post:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    
    <pagination
      v-show="total>0"
      :total="total"
      v-model:page="queryParams.pageNum"
      v-model:limit="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改帖子对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="postRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="用户" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入用户" />
        </el-form-item>
        <el-form-item label="文本内容" prop="contentText">
          <el-input v-model="form.contentText" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="图片地址" prop="contentImage">
          <image-upload v-model="form.contentImage"/>
        </el-form-item>
        <el-form-item label="点赞数" prop="likeCount">
          <el-input v-model="form.likeCount" placeholder="请输入点赞数" />
        </el-form-item>
        <el-form-item label="评论数" prop="commentCount">
          <el-input v-model="form.commentCount" placeholder="请输入评论数" />
        </el-form-item>
        <el-form-item label="标签" prop="tagId">
          <el-input v-model="form.tagId" placeholder="请输入标签" />
        </el-form-item>
        <el-form-item label="发布位置" prop="addressId">
          <el-input v-model="form.addressId" placeholder="请输入发布位置" />
        </el-form-item>
        <el-form-item label="是否公开" prop="isPublic">
          <el-input v-model="form.isPublic" placeholder="请输入是否公开" />
        </el-form-item>
        <el-form-item label="收藏数量" prop="favoriteCount">
          <el-input v-model="form.favoriteCount" placeholder="请输入收藏数量" />
        </el-form-item>
        <el-form-item label="帖子状态" prop="status">
          <el-select v-model="form.status" placeholder="请选择帖子状态">
            <el-option
              v-for="dict in post_status"
              :key="dict.value"
              :label="dict.label"
              :value="parseInt(dict.value)"
            ></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="submitForm">确 定</el-button>
          <el-button @click="cancel">取 消</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script setup name="Post">
import { listPost, getPost, delPost, addPost, updatePost } from "@/api/post/post";

const { proxy } = getCurrentInstance();
const { post_status } = proxy.useDict('post_status');

const postList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userId: null,
    contentText: null,
    likeCount: null,
    status: null,
  },
  rules: {
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询帖子列表 */
function getList() {
  loading.value = true;
  listPost(queryParams.value).then(response => {
    postList.value = response.rows;
    total.value = response.total;
    loading.value = false;
  });
}

// 取消按钮
function cancel() {
  open.value = false;
  reset();
}

// 表单重置
function reset() {
  form.value = {
    id: null,
    userId: null,
    contentText: null,
    contentImage: null,
    likeCount: null,
    commentCount: null,
    tagId: null,
    addressId: null,
    isPublic: null,
    favoriteCount: null,
    draftStatus: null,
    status: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null
  };
  proxy.resetForm("postRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  queryParams.value.pageNum = 1;
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

// 多选框选中数据
function handleSelectionChange(selection) {
  ids.value = selection.map(item => item.id);
  single.value = selection.length != 1;
  multiple.value = !selection.length;
}

/** 新增按钮操作 */
function handleAdd() {
  reset();
  open.value = true;
  title.value = "添加帖子";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row.id || ids.value
  getPost(_id).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改帖子";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["postRef"].validate(valid => {
    if (valid) {
      if (form.value.id != null) {
        updatePost(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addPost(form.value).then(response => {
          proxy.$modal.msgSuccess("新增成功");
          open.value = false;
          getList();
        });
      }
    }
  });
}

/** 删除按钮操作 */
function handleDelete(row) {
  const _ids = row.id || ids.value;
  proxy.$modal.confirm('是否确认删除帖子编号为"' + _ids + '"的数据项？').then(function() {
    return delPost(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('post/post/export', {
    ...queryParams.value
  }, `post_${new Date().getTime()}.xlsx`)
}

getList();
</script>

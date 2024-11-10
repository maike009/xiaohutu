<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="所评论的帖子ID，用于连接帖子表" prop="postId">
        <el-input
          v-model="queryParams.postId"
          placeholder="请输入所评论的帖子ID，用于连接帖子表"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="评论用户ID，用于连接用户基础表(user_id)" prop="userId">
        <el-input
          v-model="queryParams.userId"
          placeholder="请输入评论用户ID，用于连接用户基础表(user_id)"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="父评论id" prop="parentCommentId">
        <el-input
          v-model="queryParams.parentCommentId"
          placeholder="请输入父评论id"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="顶级评论id(0代表是）" prop="topId">
        <el-input
          v-model="queryParams.topId"
          placeholder="请输入顶级评论id(0代表是）"
          clearable
          @keyup.enter="handleQuery"
        />
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
          v-hasPermi="['post:comment:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="info"
          plain
          icon="Sort"
          @click="toggleExpandAll"
        >展开/折叠</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table
      v-if="refreshTable"
      v-loading="loading"
      :data="commentList"
      row-key="commentId"
      :default-expand-all="isExpandAll"
      :tree-props="{children: 'children', hasChildren: 'hasChildren'}"
    >
      <el-table-column label="所评论的帖子ID，用于连接帖子表" prop="postId" />
      <el-table-column label="评论用户ID，用于连接用户基础表(user_id)" align="center" prop="userId" />
      <el-table-column label="评论内容(text)" align="center" prop="commentText" />
      <el-table-column label="评论内容(image)" align="center" prop="commentImage" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.commentImage" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="父评论id" align="center" prop="parentCommentId" />
      <el-table-column label="顶级评论id(0代表是）" align="center" prop="topId" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['post:comment:edit']">修改</el-button>
          <el-button link type="primary" icon="Plus" @click="handleAdd(scope.row)" v-hasPermi="['post:comment:add']">新增</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['post:comment:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 添加或修改评论对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="commentRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="所评论的帖子ID，用于连接帖子表" prop="postId">
          <el-input v-model="form.postId" placeholder="请输入所评论的帖子ID，用于连接帖子表" />
        </el-form-item>
        <el-form-item label="评论用户ID，用于连接用户基础表(user_id)" prop="userId">
          <el-input v-model="form.userId" placeholder="请输入评论用户ID，用于连接用户基础表(user_id)" />
        </el-form-item>
        <el-form-item label="评论内容(text)" prop="commentText">
          <el-input v-model="form.commentText" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="评论内容(image)" prop="commentImage">
          <image-upload v-model="form.commentImage"/>
        </el-form-item>
        <el-form-item label="父评论id" prop="parentCommentId">
          <el-tree-select
            v-model="form.parentCommentId"
            :data="commentOptions"
            :props="{ value: 'commentId', label: 'commentText', children: 'children' }"
            value-key="commentId"
            placeholder="请选择父评论id"
            check-strictly
          />
        </el-form-item>
        <el-form-item label="顶级评论id(0代表是）" prop="topId">
          <el-input v-model="form.topId" placeholder="请输入顶级评论id(0代表是）" />
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

<script setup name="Comment">
import { listComment, getComment, delComment, addComment, updateComment } from "@/api/post/comment";

const { proxy } = getCurrentInstance();

const commentList = ref([]);
const commentOptions = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const title = ref("");
const isExpandAll = ref(true);
const refreshTable = ref(true);

const data = reactive({
  form: {},
  queryParams: {
    postId: null,
    userId: null,
    commentText: null,
    commentImage: null,
    parentCommentId: null,
    topId: null,
  },
  rules: {
    postId: [
      { required: true, message: "所评论的帖子ID，用于连接帖子表不能为空", trigger: "blur" }
    ],
    userId: [
      { required: true, message: "评论用户ID，用于连接用户基础表(user_id)不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询评论列表 */
function getList() {
  loading.value = true;
  listComment(queryParams.value).then(response => {
    commentList.value = proxy.handleTree(response.data, "commentId", "parentCommentId");
    loading.value = false;
  });
}

/** 查询评论下拉树结构 */
function getTreeselect() {
  listComment().then(response => {
    commentOptions.value = [];
    const data = { commentId: 0, commentText: '顶级节点', children: [] };
    data.children = proxy.handleTree(response.data, "commentId", "parentCommentId");
    commentOptions.value.push(data);
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
    commentId: null,
    postId: null,
    userId: null,
    commentText: null,
    commentTime: null,
    commentImage: null,
    parentCommentId: null,
    topId: null,
    createTime: null,
    updateTime: null
  };
  proxy.resetForm("commentRef");
}

/** 搜索按钮操作 */
function handleQuery() {
  getList();
}

/** 重置按钮操作 */
function resetQuery() {
  proxy.resetForm("queryRef");
  handleQuery();
}

/** 新增按钮操作 */
function handleAdd(row) {
  reset();
  getTreeselect();
  if (row != null && row.commentId) {
    form.value.parentCommentId = row.commentId;
  } else {
    form.value.parentCommentId = 0;
  }
  open.value = true;
  title.value = "添加评论";
}

/** 展开/折叠操作 */
function toggleExpandAll() {
  refreshTable.value = false;
  isExpandAll.value = !isExpandAll.value;
  nextTick(() => {
    refreshTable.value = true;
  });
}

/** 修改按钮操作 */
async function handleUpdate(row) {
  reset();
  await getTreeselect();
  if (row != null) {
    form.value.parentCommentId = row.parentCommentId;
  }
  getComment(row.commentId).then(response => {
    form.value = response.data;
    open.value = true;
    title.value = "修改评论";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["commentRef"].validate(valid => {
    if (valid) {
      if (form.value.commentId != null) {
        updateComment(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addComment(form.value).then(response => {
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
  proxy.$modal.confirm('是否确认删除评论编号为"' + row.commentId + '"的数据项？').then(function() {
    return delComment(row.commentId);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

getList();
</script>

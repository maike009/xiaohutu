<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryRef" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="用户名" prop="userName">
        <el-input
          v-model="queryParams.userName"
          placeholder="请输入用户名"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>
      <el-form-item label="性别" prop="gender">
        <el-select v-model="queryParams.gender" placeholder="请选择性别" clearable style="width: 190px">
          <el-option
            v-for="dict in sys_user_sex"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="昵称" prop="nickName">
        <el-input
          v-model="queryParams.nickName"
          placeholder="请输入昵称"
          clearable
          @keyup.enter="handleQuery"
        />
      </el-form-item>


      <el-form-item label="帐号状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择帐号状态" clearable style="width: 190px">
          <el-option
            v-for="dict in user_status"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="是否注销" prop="delFlag">
        <el-select v-model="queryParams.delFlag" placeholder="请选择注销状态" clearable style="width: 190px">
          <el-option
            v-for="dict in user_del_flag"
            :key="dict.value"
            :label="dict.label"
            :value="dict.value"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="更新时间" prop="updateTime">
        <el-date-picker clearable
          v-model="queryParams.updateTime"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="请选择更新时间">
        </el-date-picker>
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
          v-hasPermi="['user:user:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="Edit"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['user:user:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="Delete"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['user:user:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="Download"
          @click="handleExport"
          v-hasPermi="['user:user:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar v-model:showSearch="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="userList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="用户id" align="center" prop="id" width="80"/>
      <el-table-column label="用户名" align="center" prop="userName" />
      <el-table-column label="用户头像地址" align="center" prop="avatar" width="100">
        <template #default="scope">
          <image-preview :src="scope.row.avatar" :width="50" :height="50"/>
        </template>
      </el-table-column>
      <el-table-column label="性别" align="center" prop="gender">
        <template #default="scope">
          <dict-tag :options="sys_user_sex" :value="scope.row.gender"/>
        </template>
      </el-table-column>
      <el-table-column label="昵称" align="center" prop="nickName" />
      <el-table-column label="手机号" align="center" prop="phone" />
      <el-table-column label="用户邮件" align="center" prop="email" />
      <el-table-column label="帐号状态" align="center" prop="status">
        <template #default="scope">
          <dict-tag :options="user_status" :value="scope.row.status"/>
        </template>
      </el-table-column>
      <el-table-column label="是否注销" align="center" prop="delFlag">
        <template #default="scope">
          <dict-tag :options="user_del_flag" :value="scope.row.delFlag"/>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template #default="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button link type="primary" icon="Edit" @click="handleUpdate(scope.row)" v-hasPermi="['user:user:edit']">修改</el-button>
          <el-button link type="primary" icon="Delete" @click="handleDelete(scope.row)" v-hasPermi="['user:user:remove']">删除</el-button>
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

    <!-- 添加或修改前台用户管理对话框 -->
    <el-dialog :title="title" v-model="open" width="500px" append-to-body>
      <el-form ref="userRef" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="用户名" prop="userName">
          <el-input v-model="form.userName" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="用户头像地址" prop="avatar">
          <image-upload v-model="form.avatar"/>
        </el-form-item>
        <el-form-item label="性别" prop="gender">
          <el-radio-group v-model="form.gender">
            <el-radio
              v-for="dict in sys_user_sex"
              :key="dict.value"
              :label="parseInt(dict.value)"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="昵称" prop="nickName">
          <el-input v-model="form.nickName" placeholder="请输入昵称" />
        </el-form-item>
        <el-form-item label="手机号" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入手机号" />
        </el-form-item>
        <el-form-item label="用户邮件" prop="email">
          <el-input v-model="form.email" placeholder="请输入用户邮件" />
        </el-form-item>
        <el-form-item label="帐号状态" prop="status">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in user_status"
              :key="dict.value"
              :label="dict.value"
            >{{dict.label}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-divider content-position="center">用户详情信息</el-divider>
        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" icon="Plus" @click="handleAddUserInfo">添加</el-button>
          </el-col>
          <el-col :span="1.5">
            <el-button type="danger" icon="Delete" @click="handleDeleteUserInfo">删除</el-button>
          </el-col>
        </el-row>
        <el-table :data="userInfoList" :row-class-name="rowUserInfoIndex" @selection-change="handleUserInfoSelectionChange" ref="userInfo">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="序号" align="center" prop="index" width="50"/>
          <el-table-column label="出生日期" prop="birthDate" width="240">
            <template #default="scope">
              <el-date-picker clearable
                v-model="scope.row.birthDate"
                type="date"
                value-format="YYYY-MM-DD"
                placeholder="请选择出生日期">
              </el-date-picker>
            </template>
          </el-table-column>
          <el-table-column label="位置id" prop="addressId" width="150">
            <template #default="scope">
              <el-input v-model="scope.row.addressId" placeholder="请输入位置id" />
            </template>
          </el-table-column>
          <el-table-column label="关注者数量" prop="followersCount" width="150">
            <template #default="scope">
              <el-input v-model="scope.row.followersCount" placeholder="请输入关注者数量" />
            </template>
          </el-table-column>
          <el-table-column label="关注数量" prop="followingCount" width="150">
            <template #default="scope">
              <el-input v-model="scope.row.followingCount" placeholder="请输入关注数量" />
            </template>
          </el-table-column>
          <el-table-column label="帖子总点赞数" prop="allLikes" width="150">
            <template #default="scope">
              <el-input v-model="scope.row.allLikes" placeholder="请输入帖子总点赞数" />
            </template>
          </el-table-column>
        </el-table>
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

<script setup name="User">
import { listUser, getUser, delUser, addUser, updateUser } from "@/api/user/user";
const { proxy } = getCurrentInstance();
const { user_status, sys_user_sex, user_del_flag } = proxy.useDict('user_status', 'sys_user_sex', 'user_del_flag');

const userList = ref([]);
const userInfoList = ref([]);
const open = ref(false);
const loading = ref(true);
const showSearch = ref(true);
const ids = ref([]);
const checkedUserInfo = ref([]);
const single = ref(true);
const multiple = ref(true);
const total = ref(0);
const title = ref("");

const data = reactive({
  form: {},
  queryParams: {
    pageNum: 1,
    pageSize: 10,
    userName: null,
    avatar: null,
    gender: null,
    nickName: null,
    phone: null,
    email: null,
    status: null,
    delFlag: null,
    updateTime: null,
  },
  rules: {
    userName: [
      { required: true, message: "用户名不能为空", trigger: "blur" }
    ],
    gender: [
      { required: true, message: "性别不能为空", trigger: "change" }
    ],
    nickName: [
      { required: true, message: "昵称不能为空", trigger: "blur" }
    ],
    phone: [
      { required: true, message: "手机号不能为空", trigger: "blur" }
    ],
    email: [
      { required: true, message: "用户邮件不能为空", trigger: "blur" }
    ],
  }
});

const { queryParams, form, rules } = toRefs(data);

/** 查询前台用户管理列表 */
function getList() {
  loading.value = true;
  listUser(queryParams.value).then(response => {
    userList.value = response.rows;
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
    userName: null,
    password: null,
    avatar: null,
    gender: null,
    nickName: null,
    phone: null,
    email: null,
    status: null,
    delFlag: null,
    loginIp: null,
    loginDate: null,
    createBy: null,
    createTime: null,
    updateBy: null,
    updateTime: null,
    remark: null
  };
  userInfoList.value = [];
  proxy.resetForm("userRef");
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
  title.value = "添加前台用户管理";
}

/** 修改按钮操作 */
function handleUpdate(row) {
  reset();
  const _id = row.id || ids.value
  getUser(_id).then(response => {
    form.value = response.data;
    userInfoList.value = response.data.userInfoList;
    open.value = true;
    title.value = "修改前台用户管理";
  });
}

/** 提交按钮 */
function submitForm() {
  proxy.$refs["userRef"].validate(valid => {
    if (valid) {
      form.value.userInfoList = userInfoList.value;
      if (form.value.id != null) {
        updateUser(form.value).then(response => {
          proxy.$modal.msgSuccess("修改成功");
          open.value = false;
          getList();
        });
      } else {
        addUser(form.value).then(response => {
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
  proxy.$modal.confirm('是否确认删除前台用户名为"' + row.userName + '"的数据项？').then(function() {
    return delUser(_ids);
  }).then(() => {
    getList();
    proxy.$modal.msgSuccess("删除成功");
  }).catch(() => {});
}

/** 用户详情序号 */
function rowUserInfoIndex({ row, rowIndex }) {
  row.index = rowIndex + 1;
}

/** 用户详情添加按钮操作 */
function handleAddUserInfo() {
  let obj = {};
  obj.birthDate = "";
  obj.bio = "";
  obj.addressId = "";
  obj.followersCount = "";
  obj.followingCount = "";
  obj.allLikes = "";
  userInfoList.value.push(obj);
}

/** 用户详情删除按钮操作 */
function handleDeleteUserInfo() {
  if (checkedUserInfo.value.length == 0) {
    proxy.$modal.msgError("请先选择要删除的用户详情数据");
  } else {
    const userInfos = userInfoList.value;
    const checkedUserInfos = checkedUserInfo.value;
    userInfoList.value = userInfos.filter(function(item) {
      return checkedUserInfos.indexOf(item.index) == -1
    });
  }
}

/** 复选框选中数据 */
function handleUserInfoSelectionChange(selection) {
  checkedUserInfo.value = selection.map(item => item.index)
}

/** 导出按钮操作 */
function handleExport() {
  proxy.download('user/user/export', {
    ...queryParams.value
  }, `user_${new Date().getTime()}.xlsx`)
}

getList();
</script>

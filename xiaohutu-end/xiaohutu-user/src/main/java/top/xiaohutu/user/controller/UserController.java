package top.xiaohutu.user.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import top.xiaohutu.common.annotation.Log;
import top.xiaohutu.common.core.controller.BaseController;
import top.xiaohutu.common.core.domain.AjaxResult;
import top.xiaohutu.common.enums.BusinessType;
import top.xiaohutu.user.domain.User;
import top.xiaohutu.user.service.IUserService;
import top.xiaohutu.common.utils.poi.ExcelUtil;
import top.xiaohutu.common.core.page.TableDataInfo;

/**
 * 前台用户管理Controller
 * 
 * @author maike
 * @date 2024-10-28
 */
@RestController
@RequestMapping("/user/user")
public class UserController extends BaseController
{
    @Autowired
    private IUserService userService;

    /**
     * 查询前台用户管理列表
     */
    @PreAuthorize("@ss.hasPermi('user:user:list')")
    @GetMapping("/list")
    public TableDataInfo list(User user)
    {
        startPage();
        List<User> list = userService.selectUserList(user);
        return getDataTable(list);
    }

    /**
     * 导出前台用户管理列表
     */
    @PreAuthorize("@ss.hasPermi('user:user:export')")
    @Log(title = "前台用户管理", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, User user)
    {
        List<User> list = userService.selectUserList(user);
        ExcelUtil<User> util = new ExcelUtil<User>(User.class);
        util.exportExcel(response, list, "前台用户管理数据");
    }

    /**
     * 获取前台用户管理详细信息
     */
    @PreAuthorize("@ss.hasPermi('user:user:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(userService.selectUserById(id));
    }

    /**
     * 新增前台用户管理
     */
    @PreAuthorize("@ss.hasPermi('user:user:add')")
    @Log(title = "前台用户管理", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody User user)
    {
        return toAjax(userService.insertUser(user));
    }

    /**
     * 修改前台用户管理
     */
    @PreAuthorize("@ss.hasPermi('user:user:edit')")
    @Log(title = "前台用户管理", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody User user)
    {
        return toAjax(userService.updateUser(user));
    }

    /**
     * 删除前台用户管理
     */
    @PreAuthorize("@ss.hasPermi('user:user:remove')")
    @Log(title = "前台用户管理", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(userService.deleteUserByIds(ids));
    }
}

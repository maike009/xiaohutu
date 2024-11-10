package top.xiaohutu.system.controller;

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
import top.xiaohutu.system.domain.UserInfo;
import top.xiaohutu.system.service.IUserInfoService;
import top.xiaohutu.common.utils.poi.ExcelUtil;
import top.xiaohutu.common.core.page.TableDataInfo;

/**
 * 用户详情Controller
 * 
 * @author maike
 * @date 2024-11-09
 */
@RestController
@RequestMapping("/system/userInfo")
public class UserInfoController extends BaseController
{
    @Autowired
    private IUserInfoService userInfoService;

    /**
     * 查询用户详情列表
     */
    @PreAuthorize("@ss.hasPermi('system:userInfo:list')")
    @GetMapping("/list")
    public TableDataInfo list(UserInfo userInfo)
    {
        startPage();
        List<UserInfo> list = userInfoService.selectUserInfoList(userInfo);
        return getDataTable(list);
    }

    /**
     * 导出用户详情列表
     */
    @PreAuthorize("@ss.hasPermi('system:userInfo:export')")
    @Log(title = "用户详情", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserInfo userInfo)
    {
        List<UserInfo> list = userInfoService.selectUserInfoList(userInfo);
        ExcelUtil<UserInfo> util = new ExcelUtil<UserInfo>(UserInfo.class);
        util.exportExcel(response, list, "用户详情数据");
    }

    /**
     * 获取用户详情详细信息
     */
    @PreAuthorize("@ss.hasPermi('system:userInfo:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(userInfoService.selectUserInfoById(id));
    }

    /**
     * 新增用户详情
     */
    @PreAuthorize("@ss.hasPermi('system:userInfo:add')")
    @Log(title = "用户详情", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody UserInfo userInfo)
    {
        return toAjax(userInfoService.insertUserInfo(userInfo));
    }

    /**
     * 修改用户详情
     */
    @PreAuthorize("@ss.hasPermi('system:userInfo:edit')")
    @Log(title = "用户详情", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody UserInfo userInfo)
    {
        return toAjax(userInfoService.updateUserInfo(userInfo));
    }

    /**
     * 删除用户详情
     */
    @PreAuthorize("@ss.hasPermi('system:userInfo:remove')")
    @Log(title = "用户详情", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(userInfoService.deleteUserInfoByIds(ids));
    }
}

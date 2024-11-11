package top.xiaohutu.post.controller;

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
import top.xiaohutu.post.domain.Follower;
import top.xiaohutu.post.service.IFollowerService;
import top.xiaohutu.common.utils.poi.ExcelUtil;
import top.xiaohutu.common.core.page.TableDataInfo;

/**
 * 关注功能Controller
 * 
 * @author maike
 * @date 2024-11-11
 */
@RestController
@RequestMapping("/post/follower")
public class FollowerController extends BaseController
{
    @Autowired
    private IFollowerService followerService;

    /**
     * 查询关注功能列表
     */
    @PreAuthorize("@ss.hasPermi('post:follower:list')")
    @GetMapping("/list")
    public TableDataInfo list(Follower follower)
    {
        startPage();
        List<Follower> list = followerService.selectFollowerList(follower);
        return getDataTable(list);
    }

    /**
     * 导出关注功能列表
     */
    @PreAuthorize("@ss.hasPermi('post:follower:export')")
    @Log(title = "关注功能", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Follower follower)
    {
        List<Follower> list = followerService.selectFollowerList(follower);
        ExcelUtil<Follower> util = new ExcelUtil<Follower>(Follower.class);
        util.exportExcel(response, list, "关注功能数据");
    }

    /**
     * 获取关注功能详细信息
     */
    @PreAuthorize("@ss.hasPermi('post:follower:query')")
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId)
    {
        return success(followerService.selectFollowerByUserId(userId));
    }

    /**
     * 新增关注功能
     */
    @Log(title = "关注功能", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Follower follower)
    {
        return toAjax(followerService.insertFollower(follower));
    }

    /**
     * 修改关注功能
     */
    @PreAuthorize("@ss.hasPermi('post:follower:edit')")
    @Log(title = "关注功能", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Follower follower)
    {
        return toAjax(followerService.updateFollower(follower));
    }

    /**
     * 删除关注功能
     */
    @Log(title = "关注功能", businessType = BusinessType.DELETE)
	@DeleteMapping("/{followerId}")
    public AjaxResult remove(@PathVariable Long followerId)
    {
        return toAjax(followerService.deleteFollowerByUserId(followerId));
    }
}

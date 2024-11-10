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
import top.xiaohutu.post.domain.UserLike;
import top.xiaohutu.post.service.IUserLikeService;
import top.xiaohutu.common.utils.poi.ExcelUtil;
import top.xiaohutu.common.core.page.TableDataInfo;

/**
 * 点赞Controller
 * 
 * @author maike
 * @date 2024-11-09
 */
@RestController
@RequestMapping("/post/like")
public class UserLikeController extends BaseController
{
    @Autowired
    private IUserLikeService userLikeService;

    /**
     * 查询点赞列表
     */
    @PreAuthorize("@ss.hasPermi('post:like:list')")
    @GetMapping("/list")
    public TableDataInfo list(UserLike userLike)
    {
        startPage();
        List<UserLike> list = userLikeService.selectUserLikeList(userLike);
        return getDataTable(list);
    }

    /**
     * 导出点赞列表
     */
    @PreAuthorize("@ss.hasPermi('post:like:export')")
    @Log(title = "点赞", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserLike userLike)
    {
        List<UserLike> list = userLikeService.selectUserLikeList(userLike);
        ExcelUtil<UserLike> util = new ExcelUtil<UserLike>(UserLike.class);
        util.exportExcel(response, list, "点赞数据");
    }

    /**
     * 获取点赞详细信息
     */
    @PreAuthorize("@ss.hasPermi('post:like:query')")
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId)
    {
        return success(userLikeService.selectUserLikeByUserId(userId));
    }

    /**
     * 新增点赞
     */
    @Log(title = "点赞", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody UserLike userLike)
    {
        return toAjax(userLikeService.insertUserLike(userLike));
    }

    /**
     * 修改点赞
     */
    @PreAuthorize("@ss.hasPermi('post:like:edit')")
    @Log(title = "点赞", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody UserLike userLike)
    {
        return toAjax(userLikeService.updateUserLike(userLike));
    }

    /**
     * 删除点赞
     */
    @Log(title = "点赞", businessType = BusinessType.DELETE)
	@DeleteMapping("/delete")
    public AjaxResult remove(@RequestBody UserLike userLike)
    {
        return toAjax(userLikeService.deleteUserLikeByUserIds(userLike));
    }
}

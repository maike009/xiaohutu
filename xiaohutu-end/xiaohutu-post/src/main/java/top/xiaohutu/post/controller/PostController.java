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
import top.xiaohutu.post.domain.Post;
import top.xiaohutu.post.domain.vo.PostVO;
import top.xiaohutu.post.service.IPostService;
import top.xiaohutu.common.utils.poi.ExcelUtil;
import top.xiaohutu.common.core.page.TableDataInfo;

/**
 * 帖子Controller
 * 
 * @author maike
 * @date 2024-11-01
 */
@RestController
@RequestMapping("/post/post")
public class PostController extends BaseController
{
    @Autowired
    private IPostService postService;

    /**
     * 查询帖子列表
     */
    @PreAuthorize("@ss.hasPermi('post:post:list')")
    @GetMapping("/list")
    public TableDataInfo list(Post post)
    {
        startPage();
        List<PostVO> list = postService.selectPostList(post);
        return getDataTable(list);
    }

    @GetMapping("/frontList")
    public TableDataInfo frontList(Post post)
    {
        startPage();
        List<PostVO> list = postService.selectFrontPostList(post);
        return getDataTable(list);
    }

    /**
     * 导出帖子列表
     */
    @PreAuthorize("@ss.hasPermi('post:post:export')")
    @Log(title = "帖子", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Post post)
    {
        List<PostVO> list = postService.selectPostList(post);
        ExcelUtil<PostVO> util = new ExcelUtil<PostVO>(PostVO.class);
        util.exportExcel(response, list, "帖子数据");
    }

    /**
     * 获取帖子详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(postService.selectPostById(id));
    }

    /**
     * 新增帖子
     */
    @Log(title = "帖子", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Post post)
    {
        return toAjax(postService.insertPost(post));
    }

    /**
     * 修改帖子
     */
    @PreAuthorize("@ss.hasPermi('post:post:edit')")
    @Log(title = "帖子", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Post post)
    {
        return toAjax(postService.updatePost(post));
    }

    /**
     * 删除帖子
     */
    @PreAuthorize("@ss.hasPermi('post:post:remove')")
    @Log(title = "帖子", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(postService.deletePostByIds(ids));
    }
}

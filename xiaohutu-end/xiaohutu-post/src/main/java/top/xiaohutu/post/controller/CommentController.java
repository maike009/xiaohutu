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
import top.xiaohutu.common.core.page.TableDataInfo;
import top.xiaohutu.common.enums.BusinessType;
import top.xiaohutu.post.domain.Comment;
import top.xiaohutu.post.domain.vo.CommentVO;
import top.xiaohutu.post.service.ICommentService;
import top.xiaohutu.common.utils.poi.ExcelUtil;

/**
 * 评论Controller
 * 
 * @author maike
 * @date 2024-11-09
 */
@RestController
@RequestMapping("/post/comment")
public class CommentController extends BaseController
{
    @Autowired
    private ICommentService commentService;

    /**
     * 查询评论列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Comment comment)
    {
        startPage();
        List<CommentVO> list = commentService.selectCommentList(comment);
        return getDataTable(list);
    }

    /**
     * 导出评论列表
     */
    @PreAuthorize("@ss.hasPermi('post:comment:export')")
    @Log(title = "评论", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Comment comment)
    {
        List<CommentVO> list = commentService.selectCommentList(comment);
        ExcelUtil<CommentVO> util = new ExcelUtil<CommentVO>(CommentVO.class);
        util.exportExcel(response, list, "评论数据");
    }

    /**
     * 获取评论详细信息
     */
    @PreAuthorize("@ss.hasPermi('post:comment:query')")
    @GetMapping(value = "/{commentId}")
    public AjaxResult getInfo(@PathVariable("commentId") Long commentId)
    {
        return success(commentService.selectCommentByCommentId(commentId));
    }

    /**
     * 新增评论
     */
    @Log(title = "评论", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Comment comment)
    {
        return toAjax(commentService.insertComment(comment));
    }

    /**
     * 修改评论
     */
    @PreAuthorize("@ss.hasPermi('post:comment:edit')")
    @Log(title = "评论", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Comment comment)
    {
        return toAjax(commentService.updateComment(comment));
    }

    /**
     * 删除评论
     */
    @PreAuthorize("@ss.hasPermi('post:comment:remove')")
    @Log(title = "评论", businessType = BusinessType.DELETE)
	@DeleteMapping("/{commentIds}")
    public AjaxResult remove(@PathVariable Long[] commentIds)
    {
        return toAjax(commentService.deleteCommentByCommentIds(commentIds));
    }
}

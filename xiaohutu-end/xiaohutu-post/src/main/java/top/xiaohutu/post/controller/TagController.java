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
import top.xiaohutu.post.domain.Tag;
import top.xiaohutu.post.service.ITagService;
import top.xiaohutu.common.utils.poi.ExcelUtil;
import top.xiaohutu.common.core.page.TableDataInfo;

/**
 * 标签（分类）Controller
 * 
 * @author maike
 * @date 2024-11-07
 */
@RestController
@RequestMapping("/post/tag")
public class TagController extends BaseController
{
    @Autowired
    private ITagService tagService;

    /**
     * 查询标签（分类）列表
     */
    @GetMapping("/list")
    public TableDataInfo list(Tag tag)
    {
        startPage();
        List<Tag> list = tagService.selectTagList(tag);
        return getDataTable(list);
    }

    /**
     * 导出标签（分类）列表
     */
    @PreAuthorize("@ss.hasPermi('post:tag:export')")
    @Log(title = "标签（分类）", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, Tag tag)
    {
        List<Tag> list = tagService.selectTagList(tag);
        ExcelUtil<Tag> util = new ExcelUtil<Tag>(Tag.class);
        util.exportExcel(response, list, "标签（分类）数据");
    }

    /**
     * 获取标签（分类）详细信息
     */
    @PreAuthorize("@ss.hasPermi('post:tag:query')")
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        return success(tagService.selectTagById(id));
    }

    /**
     * 新增标签（分类）
     */
    @PreAuthorize("@ss.hasPermi('post:tag:add')")
    @Log(title = "标签（分类）", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody Tag tag)
    {
        return toAjax(tagService.insertTag(tag));
    }

    /**
     * 修改标签（分类）
     */
    @PreAuthorize("@ss.hasPermi('post:tag:edit')")
    @Log(title = "标签（分类）", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Tag tag)
    {
        return toAjax(tagService.updateTag(tag));
    }

    /**
     * 删除标签（分类）
     */
    @PreAuthorize("@ss.hasPermi('post:tag:remove')")
    @Log(title = "标签（分类）", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(tagService.deleteTagByIds(ids));
    }
}

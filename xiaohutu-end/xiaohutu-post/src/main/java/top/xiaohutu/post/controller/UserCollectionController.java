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
import top.xiaohutu.post.domain.UserCollection;
import top.xiaohutu.post.service.IUserCollectionService;
import top.xiaohutu.common.utils.poi.ExcelUtil;
import top.xiaohutu.common.core.page.TableDataInfo;

/**
 * 收藏Controller
 * 
 * @author maike
 * @date 2024-11-09
 */
@RestController
@RequestMapping("/post/collection")
public class UserCollectionController extends BaseController
{
    @Autowired
    private IUserCollectionService userCollectionService;

    /**
     * 查询收藏列表
     */
    @PreAuthorize("@ss.hasPermi('post:collection:list')")
    @GetMapping("/list")
    public TableDataInfo list(UserCollection userCollection)
    {
        startPage();
        List<UserCollection> list = userCollectionService.selectUserCollectionList(userCollection);
        return getDataTable(list);
    }

    /**
     * 导出收藏列表
     */
    @PreAuthorize("@ss.hasPermi('post:collection:export')")
    @Log(title = "收藏", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, UserCollection userCollection)
    {
        List<UserCollection> list = userCollectionService.selectUserCollectionList(userCollection);
        ExcelUtil<UserCollection> util = new ExcelUtil<UserCollection>(UserCollection.class);
        util.exportExcel(response, list, "收藏数据");
    }

    /**
     * 获取收藏详细信息
     */
    @PreAuthorize("@ss.hasPermi('post:collection:query')")
    @GetMapping(value = "/{userId}")
    public AjaxResult getInfo(@PathVariable("userId") Long userId)
    {
        return success(userCollectionService.selectUserCollectionByUserId(userId));
    }

    /**
     * 新增收藏
     */
    @Log(title = "收藏", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody UserCollection userCollection)
    {
        return toAjax(userCollectionService.insertUserCollection(userCollection));
    }

    /**
     * 修改收藏
     */
    @PreAuthorize("@ss.hasPermi('post:collection:edit')")
    @Log(title = "收藏", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody UserCollection userCollection)
    {
        return toAjax(userCollectionService.updateUserCollection(userCollection));
    }

    /**
     * 删除收藏
     */
    @Log(title = "收藏", businessType = BusinessType.DELETE)
	@DeleteMapping("/delete")
    public AjaxResult remove(@RequestBody UserCollection userCollection)
    {
        return toAjax(userCollectionService.deleteUserCollectionByUserIds(userCollection));
    }
}

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
import top.xiaohutu.common.core.redis.RedisCache;
import top.xiaohutu.common.enums.BusinessType;
import top.xiaohutu.common.utils.SecurityUtils;
import top.xiaohutu.post.domain.Post;
import top.xiaohutu.post.domain.UserCollection;
import top.xiaohutu.post.domain.UserLike;
import top.xiaohutu.post.domain.vo.PostVO;
import top.xiaohutu.post.mapper.UserCollectionMapper;
import top.xiaohutu.post.mapper.UserLikeMapper;
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


    /**
     * 获取前台帖子列表
     * @param post
     * @return
     */
    @GetMapping("/frontList")
    public TableDataInfo frontList(Post post)
    {
        startPage();
        List<PostVO> list = postService.selectFrontPostList(post);

        return getDataTable(list);
    }
    /**
     * 获取我的帖子列表
     */
    @GetMapping("/myList")
    public TableDataInfo myList(Post post)
    {
        startPage();
        Long userId = SecurityUtils.getUserId();
        post.setUserId(userId);
        List<PostVO> list = postService.selectMyFrontPostList(post);
        return getDataTable(list);
    }
    /**
     * 获取我点赞的帖子列表
     */
    @GetMapping("/myLikeList")
    public TableDataInfo myLikeList(Post post)
    {
        startPage();
        Long userId = SecurityUtils.getUserId();
        post.setUserId(userId);
        List<PostVO> list = postService.selectMyLikePostList(post);
        return getDataTable(list);
    }
    /**
     * 获取我收藏的帖子列表
     */
    @GetMapping("/myFavoriteList")
    public TableDataInfo myFavoriteList(Post post)
    {
        startPage();
        Long userId = SecurityUtils.getUserId();
        post.setUserId(userId);
        List<PostVO> list = postService.selectMyFavoritePostList(post);
        return getDataTable(list);

    }
    /**
     * 获取我的草稿箱
     */
    @GetMapping("/draftList")
    public TableDataInfo draftList(Post post)
    {
        startPage();
        Long userId = SecurityUtils.getUserId();
        post.setUserId(userId);
        List<PostVO> list = postService.selectMyDraftList(post);
        return getDataTable(list);
    }
    /**
     * 获取我草稿箱的帖子详情
     */
    @GetMapping("/draft/{id}")
    public AjaxResult draft(@PathVariable("id") Long id)
    {

        Post post = postService.selectPostByIdIsDraft(id,SecurityUtils.getUserId());
        return AjaxResult.success(post);
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

    @Autowired
    UserLikeMapper userLikeMapper;

    @Autowired
    UserCollectionMapper userCollectionMapper;
    /**
     * 获取帖子详细信息
     */
    @GetMapping(value = "/{id}")
    public AjaxResult getInfo(@PathVariable("id") Long id)
    {
        AjaxResult ajaxResult = AjaxResult.success(postService.selectPostById(id));
        Long userId = SecurityUtils.getUserId();
        UserLike userLike = userLikeMapper.selectUserLikeByUserIdAndPostId(userId, id);
        UserCollection userCollection = userCollectionMapper.selectUserCollectionByUserIdAndPostId(userId,id);
        if (userLike != null){
            ajaxResult.put("isLike", true);
        }
        if (userCollection != null){
            ajaxResult.put("isFavorite", true);
        }
        return ajaxResult;
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
    @Log(title = "帖子", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody Post post)
    {
        return toAjax(postService.updatePost(post));
    }

    /**
     * 删除帖子
     */
    @Log(title = "帖子", businessType = BusinessType.DELETE)
	@DeleteMapping("/{ids}")
    public AjaxResult remove(@PathVariable Long[] ids)
    {
        return toAjax(postService.deletePostByIds(ids));
    }
}

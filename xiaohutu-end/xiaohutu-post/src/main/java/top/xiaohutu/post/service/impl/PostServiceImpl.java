package top.xiaohutu.post.service.impl;

import java.util.*;

import org.springframework.transaction.annotation.Transactional;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.xiaohutu.common.utils.SecurityUtils;
import top.xiaohutu.post.domain.PostTag;
import top.xiaohutu.post.domain.vo.PostVO;
import top.xiaohutu.post.mapper.PostMapper;
import top.xiaohutu.post.domain.Post;
import top.xiaohutu.post.mapper.PostTagMapper;
import top.xiaohutu.post.service.IPostService;
import top.xiaohutu.post.service.IPostTagService;

/**
 * 帖子Service业务层处理
 * 
 * @author maike
 * @date 2024-11-01
 */
@Service
public class PostServiceImpl implements IPostService 
{
    @Autowired
    private PostMapper postMapper;

    @Autowired
    private PostTagMapper postTagMapper;
    /**
     * 查询帖子
     * 
     * @param id 帖子主键
     * @return 帖子
     */
    @Override
    public Post selectPostById(Long id)
    {
        return postMapper.selectPostById(id);
    }

    /**
     * 查询帖子列表
     * 
     * @param post 帖子
     * @return 帖子
     */
    @Override
    public List<PostVO> selectPostList(Post post)
    {
        return postMapper.selectPostList(post);
    }

    /**
     * 新增帖子
     * 
     * @param post 帖子
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertPost(Post post)
    {
        post.setUserId(SecurityUtils.getUserId());
        post.setCreateTime(DateUtils.getNowDate());
        post.setUpdateTime(DateUtils.getNowDate());
        String[] tagIds = post.getTagId().split(",");
        List<PostTag> postTags = new ArrayList<>();
        int countPost = postMapper.insertPost(post);
        if (!"".equals(post.getTagId()) && post.getTagId() == null){
            for (String tagId : tagIds) {
                postTags.add(new PostTag().setPostId(post.getId()).setTagId(Long.valueOf(tagId)));
            }
            postTagMapper.saveBatch(postTags);
        }
        return countPost;
    }

    /**
     * 修改帖子
     * 
     * @param post 帖子
     * @return 结果
     */
    @Override
    public int updatePost(Post post)
    {
        if(!SecurityUtils.getUsername().equals("admin")){
            post.setUserId(SecurityUtils.getUserId());
            post.setStatus(1L);
        }
        post.setUpdateTime(DateUtils.getNowDate());
        String[] tagIds = post.getTagId().split(",");
        List<PostTag> postTags = new ArrayList<>();
        int countPost = postMapper.updatePost(post);
        if (!"".equals(post.getTagId()) && post.getTagId() == null){
            for (String tagId : tagIds) {
                postTags.add(new PostTag().setPostId(post.getId()).setTagId(Long.valueOf(tagId)));
            }
            postTagMapper.saveBatch(postTags);
        }
        return countPost;
    }

    /**
     * 批量删除帖子
     * 
     * @param ids 需要删除的帖子主键
     * @return 结果
     */
    @Override
    public int deletePostByIds(Long[] ids)
    {
        return postMapper.deletePostByIds(ids,SecurityUtils.getUserId());
    }

    /**
     * 删除帖子信息
     * 
     * @param id 帖子主键
     * @return 结果
     */
    @Override
    public int deletePostById(Long id)
    {
        return postMapper.deletePostById(id);
    }

    @Override
    public List<PostVO> selectFrontPostList(Post post) {
        return postMapper.selectFrontPostList(post);
    }

    @Override
    public List<PostVO> selectMyLikePostList(Post post) {
        return postMapper.selectMyLikeFrontPostList(post);
    }

    @Override
    public List<PostVO> selectMyFavoritePostList(Post post) {
         return postMapper.selectMyFavoritePostList(post);
    }

    @Override
    public List<PostVO> selectMyDraftList(Post post) {
        return postMapper.selectMyDraftList(post);
    }

    @Override
    public Post selectPostByIdIsDraft(Long id,Long userId) {
        return postMapper.selectPostByIdIsDraft(id,userId);
    }

    @Override
    public List<PostVO> selectMyFrontPostList(Post post) {
        return postMapper.selectMyFrontPostList(post);
    }
}

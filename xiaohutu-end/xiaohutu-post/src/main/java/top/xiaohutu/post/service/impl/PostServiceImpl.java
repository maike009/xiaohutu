package top.xiaohutu.post.service.impl;

import java.util.Collections;
import java.util.List;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.xiaohutu.post.domain.vo.PostVO;
import top.xiaohutu.post.mapper.PostMapper;
import top.xiaohutu.post.domain.Post;
import top.xiaohutu.post.service.IPostService;

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
    public int insertPost(Post post)
    {
        post.setCreateTime(DateUtils.getNowDate());
        return postMapper.insertPost(post);
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
        post.setUpdateTime(DateUtils.getNowDate());
        return postMapper.updatePost(post);
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
        return postMapper.deletePostByIds(ids);
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
}

package top.xiaohutu.post.service;

import java.util.List;
import top.xiaohutu.post.domain.Post;
import top.xiaohutu.post.domain.vo.PostVO;

/**
 * 帖子Service接口
 * 
 * @author maike
 * @date 2024-11-01
 */
public interface IPostService 
{
    /**
     * 查询帖子
     * 
     * @param id 帖子主键
     * @return 帖子
     */
    public Post selectPostById(Long id);

    /**
     * 查询帖子列表
     * 
     * @param post 帖子
     * @return 帖子集合
     */
    public List<PostVO> selectPostList(Post post);

    /**
     * 新增帖子
     * 
     * @param post 帖子
     * @return 结果
     */
    public int insertPost(Post post);

    /**
     * 修改帖子
     * 
     * @param post 帖子
     * @return 结果
     */
    public int updatePost(Post post);

    /**
     * 批量删除帖子
     * 
     * @param ids 需要删除的帖子主键集合
     * @return 结果
     */
    public int deletePostByIds(Long[] ids);

    /**
     * 删除帖子信息
     * 
     * @param id 帖子主键
     * @return 结果
     */
    public int deletePostById(Long id);


    List<PostVO> selectFrontPostList(Post post);

    List<PostVO> selectMyLikePostList(Post post);

    List<PostVO> selectMyFavoritePostList(Post post);

    List<PostVO> selectMyDraftList(Post post);

    Post selectPostByIdIsDraft(Long id,Long userId);

    List<PostVO> selectMyFrontPostList(Post post);

    List<PostVO> selectMyHistoryPostList(Post post);
}

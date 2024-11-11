package top.xiaohutu.post.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import top.xiaohutu.post.domain.Post;
import top.xiaohutu.post.domain.vo.PostVO;

/**
 * 帖子Mapper接口
 * 
 * @author maike
 * @date 2024-11-01
 */
public interface PostMapper 
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
     * 删除帖子
     * 
     * @param id 帖子主键
     * @return 结果
     */
    public int deletePostById(Long id);

    /**
     * 批量删除帖子
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deletePostByIds(@Param("array") Long[] ids,@Param("userId") Long userId);

    List<PostVO> selectFrontPostList(Post post);

    List<PostVO> selectMyLikeFrontPostList(Post post);

    List<PostVO> selectMyFavoritePostList(Post post);

    List<PostVO> selectMyDraftList(Post post);

    Post selectPostByIdIsDraft(@Param("postId") Long id,@Param("userId") Long userId);

    List<PostVO> selectMyFrontPostList(Post post);

    List<PostVO> selectMyHistoryPostList(Post post);
}

package top.xiaohutu.post.mapper;

import java.util.List;
import top.xiaohutu.post.domain.Comment;
import top.xiaohutu.post.domain.vo.CommentVO;

/**
 * 评论Mapper接口
 * 
 * @author maike
 * @date 2024-11-09
 */
public interface CommentMapper 
{
    /**
     * 查询评论
     * 
     * @param commentId 评论主键
     * @return 评论
     */
    public Comment selectCommentByCommentId(Long commentId);

    /**
     * 查询评论列表
     * 
     * @param comment 评论
     * @return 评论集合
     */
    public List<CommentVO> selectCommentList(Comment comment);

    /**
     * 新增评论
     * 
     * @param comment 评论
     * @return 结果
     */
    public int insertComment(Comment comment);

    /**
     * 修改评论
     * 
     * @param comment 评论
     * @return 结果
     */
    public int updateComment(Comment comment);

    /**
     * 删除评论
     * 
     * @param commentId 评论主键
     * @return 结果
     */
    public int deleteCommentByCommentId(Long commentId);

    /**
     * 批量删除评论
     * 
     * @param commentIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteCommentByCommentIds(Long[] commentIds);
}

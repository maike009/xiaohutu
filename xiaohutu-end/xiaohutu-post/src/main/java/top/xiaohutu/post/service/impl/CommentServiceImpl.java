package top.xiaohutu.post.service.impl;

import java.util.List;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.xiaohutu.post.domain.vo.CommentVO;
import top.xiaohutu.post.mapper.CommentMapper;
import top.xiaohutu.post.domain.Comment;
import top.xiaohutu.post.service.ICommentService;

/**
 * 评论Service业务层处理
 * 
 * @author maike
 * @date 2024-11-09
 */
@Service
public class CommentServiceImpl implements ICommentService 
{
    @Autowired
    private CommentMapper commentMapper;

    /**
     * 查询评论
     * 
     * @param commentId 评论主键
     * @return 评论
     */
    @Override
    public Comment selectCommentByCommentId(Long commentId)
    {
        return commentMapper.selectCommentByCommentId(commentId);
    }

    /**
     * 查询评论列表
     * 
     * @param comment 评论
     * @return 评论
     */
    @Override
    public List<CommentVO> selectCommentList(Comment comment)
    {
        return commentMapper.selectCommentList(comment);
    }

    /**
     * 新增评论
     * 
     * @param comment 评论
     * @return 结果
     */
    @Override
    public int insertComment(Comment comment)
    {
        comment.setCreateTime(DateUtils.getNowDate());
        return commentMapper.insertComment(comment);
    }

    /**
     * 修改评论
     * 
     * @param comment 评论
     * @return 结果
     */
    @Override
    public int updateComment(Comment comment)
    {
        comment.setUpdateTime(DateUtils.getNowDate());
        return commentMapper.updateComment(comment);
    }

    /**
     * 批量删除评论
     * 
     * @param commentIds 需要删除的评论主键
     * @return 结果
     */
    @Override
    public int deleteCommentByCommentIds(Long[] commentIds)
    {
        return commentMapper.deleteCommentByCommentIds(commentIds);
    }

    /**
     * 删除评论信息
     * 
     * @param commentId 评论主键
     * @return 结果
     */
    @Override
    public int deleteCommentByCommentId(Long commentId)
    {
        return commentMapper.deleteCommentByCommentId(commentId);
    }
}

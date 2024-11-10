package top.xiaohutu.post.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.xiaohutu.common.annotation.Excel;
import top.xiaohutu.common.core.domain.TreeEntity;

/**
 * 评论对象 comment
 * 
 * @author maike
 * @date 2024-11-09
 */
public class Comment extends TreeEntity
{
    private static final long serialVersionUID = 1L;

    /** 评论ID */
    private Long commentId;

    /** 所评论的帖子ID，用于连接帖子表 */
    @Excel(name = "所评论的帖子ID，用于连接帖子表")
    private Long postId;

    /** 评论用户ID，用于连接用户基础表(user_id) */
    @Excel(name = "评论用户ID，用于连接用户基础表(user_id)")
    private Long userId;

    /** 评论内容(text) */
    @Excel(name = "评论内容(text)")
    private String commentText;

    /** 评论时间 */
    private Date commentTime;

    /** 评论内容(image) */
    @Excel(name = "评论内容(image)")
    private String commentImage;

    /** 父评论id */
    @Excel(name = "父评论id")
    private Long parentCommentId;

    /** 顶级评论id(0代表是） */
    @Excel(name = "顶级评论id(0代表是）")
    private Long topId;

    public void setCommentId(Long commentId) 
    {
        this.commentId = commentId;
    }

    public Long getCommentId() 
    {
        return commentId;
    }
    public void setPostId(Long postId) 
    {
        this.postId = postId;
    }

    public Long getPostId() 
    {
        return postId;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setCommentText(String commentText) 
    {
        this.commentText = commentText;
    }

    public String getCommentText() 
    {
        return commentText;
    }
    public void setCommentTime(Date commentTime) 
    {
        this.commentTime = commentTime;
    }

    public Date getCommentTime() 
    {
        return commentTime;
    }
    public void setCommentImage(String commentImage) 
    {
        this.commentImage = commentImage;
    }

    public String getCommentImage() 
    {
        return commentImage;
    }
    public void setParentCommentId(Long parentCommentId) 
    {
        this.parentCommentId = parentCommentId;
    }

    public Long getParentCommentId() 
    {
        return parentCommentId;
    }
    public void setTopId(Long topId) 
    {
        this.topId = topId;
    }

    public Long getTopId() 
    {
        return topId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("commentId", getCommentId())
            .append("postId", getPostId())
            .append("userId", getUserId())
            .append("commentText", getCommentText())
            .append("commentTime", getCommentTime())
            .append("commentImage", getCommentImage())
            .append("parentCommentId", getParentCommentId())
            .append("topId", getTopId())
            .append("createTime", getCreateTime())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}

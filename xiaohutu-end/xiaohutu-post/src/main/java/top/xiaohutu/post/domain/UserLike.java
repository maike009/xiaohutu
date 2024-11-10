package top.xiaohutu.post.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.xiaohutu.common.annotation.Excel;
import top.xiaohutu.common.core.domain.BaseEntity;

/**
 * 点赞对象 tb_user_like
 * 
 * @author maike
 * @date 2024-11-09
 */
public class UserLike extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 点赞用户ID(连接用户详情表的c_user_id) */
    private Long userId;

    /** 被点赞帖子ID */
    private Long postId;

    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setPostId(Long postId) 
    {
        this.postId = postId;
    }

    public Long getPostId() 
    {
        return postId;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("userId", getUserId())
            .append("postId", getPostId())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}

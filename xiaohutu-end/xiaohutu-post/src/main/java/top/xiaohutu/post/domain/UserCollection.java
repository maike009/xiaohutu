package top.xiaohutu.post.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.xiaohutu.common.annotation.Excel;
import top.xiaohutu.common.core.domain.BaseEntity;

/**
 * 收藏对象 tb_user_collection
 * 
 * @author maike
 * @date 2024-11-09
 */
public class UserCollection extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** (用户ID) - 外键，关联到用户表，表示哪个用户收藏了这个条目 */
    private Long userId;

    /** (微博帖子ID) - 外键，关联到微博帖子表，表示哪个微博帖子被用户收藏 */
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

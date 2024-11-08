package top.xiaohutu.post.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.xiaohutu.common.annotation.Excel;
import top.xiaohutu.common.core.domain.BaseEntity;

/**
 * 帖子对象 tb_post
 * 
 * @author maike
 * @date 2024-11-01
 */
public class Post extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 帖子ID */
    private Long id;

    /** 用户 */
    @Excel(name = "用户")
    private Long userId;

    /** 帖子标题 */
    @Excel(name = "帖子标题")
    private String postTitle;

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    /** 文本内容 */
    @Excel(name = "文本内容")
    private String contentText;

    /** 图片地址 */
    @Excel(name = "图片地址")
    private String contentImage;

    /** 点赞数 */
    @Excel(name = "点赞数")
    private Long likeCount;

    /** 评论数 */
    @Excel(name = "评论数")
    private Long commentCount;

    /** 标签 */
    @Excel(name = "标签")
    private String tagId;

    /** 发布位置 */
    @Excel(name = "发布位置")
    private Long addressId;

    /** 是否公开 */
    @Excel(name = "是否公开")
    private Integer isPublic;

    /** 收藏数量 */
    @Excel(name = "收藏数量")
    private Long favoriteCount;

    /** 是否发布（草稿） */
    @Excel(name = "是否发布", readConverterExp = "草=稿")
    private Long draftStatus;

    /** 帖子状态 */
    @Excel(name = "帖子状态")
    private Long status;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setUserId(Long userId) 
    {
        this.userId = userId;
    }

    public Long getUserId() 
    {
        return userId;
    }
    public void setContentText(String contentText) 
    {
        this.contentText = contentText;
    }

    public String getContentText() 
    {
        return contentText;
    }
    public void setContentImage(String contentImage) 
    {
        this.contentImage = contentImage;
    }

    public String getContentImage() 
    {
        return contentImage;
    }
    public void setLikeCount(Long likeCount) 
    {
        this.likeCount = likeCount;
    }

    public Long getLikeCount() 
    {
        return likeCount;
    }
    public void setCommentCount(Long commentCount) 
    {
        this.commentCount = commentCount;
    }

    public Long getCommentCount() 
    {
        return commentCount;
    }
    public void setTagId(String tagId)
    {
        this.tagId = tagId;
    }

    public String getTagId()
    {
        return tagId;
    }
    public void setAddressId(Long addressId) 
    {
        this.addressId = addressId;
    }

    public Long getAddressId() 
    {
        return addressId;
    }
    public void setIsPublic(Integer isPublic) 
    {
        this.isPublic = isPublic;
    }

    public Integer getIsPublic() 
    {
        return isPublic;
    }
    public void setFavoriteCount(Long favoriteCount) 
    {
        this.favoriteCount = favoriteCount;
    }

    public Long getFavoriteCount() 
    {
        return favoriteCount;
    }
    public void setDraftStatus(Long draftStatus) 
    {
        this.draftStatus = draftStatus;
    }

    public Long getDraftStatus() 
    {
        return draftStatus;
    }
    public void setStatus(Long status) 
    {
        this.status = status;
    }

    public Long getStatus() 
    {
        return status;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("contentText", getContentText())
            .append("contentImage", getContentImage())
            .append("likeCount", getLikeCount())
            .append("commentCount", getCommentCount())
            .append("tagId", getTagId())
            .append("addressId", getAddressId())
            .append("isPublic", getIsPublic())
            .append("favoriteCount", getFavoriteCount())
            .append("draftStatus", getDraftStatus())
            .append("status", getStatus())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}

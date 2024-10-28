package top.xiaohutu.user.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.xiaohutu.common.annotation.Excel;
import top.xiaohutu.common.core.domain.BaseEntity;

/**
 * 用户详情对象 tb_user_info
 * 
 * @author maike
 * @date 2024-10-28
 */
public class UserInfo extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** ID 主键 */
    private Long id;

    /** 用户id，连接用户基础表(c_user_id) */
    @Excel(name = "用户id，连接用户基础表(c_user_id)")
    private Long userId;

    /** 出生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "出生日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date birthDate;

    /** 个人简介 */
    @Excel(name = "个人简介")
    private String bio;

    /** 位置id */
    @Excel(name = "位置id")
    private Long addressId;

    /** 关注者数量（粉丝） */
    @Excel(name = "关注者数量", readConverterExp = "粉=丝")
    private Long followersCount;

    /** 关注数量 */
    @Excel(name = "关注数量")
    private Long followingCount;

    /** 帖子总点赞数 */
    @Excel(name = "帖子总点赞数")
    private Long allLikes;

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
    public void setBirthDate(Date birthDate) 
    {
        this.birthDate = birthDate;
    }

    public Date getBirthDate() 
    {
        return birthDate;
    }
    public void setBio(String bio) 
    {
        this.bio = bio;
    }

    public String getBio() 
    {
        return bio;
    }
    public void setAddressId(Long addressId) 
    {
        this.addressId = addressId;
    }

    public Long getAddressId() 
    {
        return addressId;
    }
    public void setFollowersCount(Long followersCount) 
    {
        this.followersCount = followersCount;
    }

    public Long getFollowersCount() 
    {
        return followersCount;
    }
    public void setFollowingCount(Long followingCount) 
    {
        this.followingCount = followingCount;
    }

    public Long getFollowingCount() 
    {
        return followingCount;
    }
    public void setAllLikes(Long allLikes) 
    {
        this.allLikes = allLikes;
    }

    public Long getAllLikes() 
    {
        return allLikes;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userId", getUserId())
            .append("birthDate", getBirthDate())
            .append("bio", getBio())
            .append("addressId", getAddressId())
            .append("followersCount", getFollowersCount())
            .append("followingCount", getFollowingCount())
            .append("allLikes", getAllLikes())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}

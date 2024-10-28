package top.xiaohutu.user.domain;

import java.util.List;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.xiaohutu.common.annotation.Excel;
import top.xiaohutu.common.core.domain.BaseEntity;

/**
 * 前台用户管理对象 tb_user
 * 
 * @author maike
 * @date 2024-10-28
 */
public class User extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 用户表id */
    private Long id;

    /** 用户名 */
    @Excel(name = "用户名")
    private String userName;

    /** 用户密码 */
    private String password;

    /** 用户头像地址 */
    @Excel(name = "用户头像地址")
    private String avatar;

    /** 性别 */
    @Excel(name = "性别")
    private Long gender;

    /** 昵称 */
    @Excel(name = "昵称")
    private String nickName;

    /** 手机号 */
    @Excel(name = "手机号")
    private String phone;

    /** 用户邮件 */
    @Excel(name = "用户邮件")
    private String email;

    /** 帐号状态 */
    @Excel(name = "帐号状态")
    private String status;

    /** 是否注销 */
    @Excel(name = "是否注销")
    private String delFlag;

    /** 最后登录IP */
    private String loginIp;

    /** 最后登录时间 */
    private Date loginDate;

    /** 用户详情信息 */
    private List<UserInfo> userInfoList;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setUserName(String userName) 
    {
        this.userName = userName;
    }

    public String getUserName() 
    {
        return userName;
    }
    public void setPassword(String password) 
    {
        this.password = password;
    }

    public String getPassword() 
    {
        return password;
    }
    public void setAvatar(String avatar) 
    {
        this.avatar = avatar;
    }

    public String getAvatar() 
    {
        return avatar;
    }
    public void setGender(Long gender) 
    {
        this.gender = gender;
    }

    public Long getGender() 
    {
        return gender;
    }
    public void setNickName(String nickName) 
    {
        this.nickName = nickName;
    }

    public String getNickName() 
    {
        return nickName;
    }
    public void setPhone(String phone) 
    {
        this.phone = phone;
    }

    public String getPhone() 
    {
        return phone;
    }
    public void setEmail(String email) 
    {
        this.email = email;
    }

    public String getEmail() 
    {
        return email;
    }
    public void setStatus(String status) 
    {
        this.status = status;
    }

    public String getStatus() 
    {
        return status;
    }
    public void setDelFlag(String delFlag) 
    {
        this.delFlag = delFlag;
    }

    public String getDelFlag() 
    {
        return delFlag;
    }
    public void setLoginIp(String loginIp) 
    {
        this.loginIp = loginIp;
    }

    public String getLoginIp() 
    {
        return loginIp;
    }
    public void setLoginDate(Date loginDate) 
    {
        this.loginDate = loginDate;
    }

    public Date getLoginDate() 
    {
        return loginDate;
    }

    public List<UserInfo> getUserInfoList()
    {
        return userInfoList;
    }

    public void setUserInfoList(List<UserInfo> userInfoList)
    {
        this.userInfoList = userInfoList;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("userName", getUserName())
            .append("password", getPassword())
            .append("avatar", getAvatar())
            .append("gender", getGender())
            .append("nickName", getNickName())
            .append("phone", getPhone())
            .append("email", getEmail())
            .append("status", getStatus())
            .append("delFlag", getDelFlag())
            .append("loginIp", getLoginIp())
            .append("loginDate", getLoginDate())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .append("userInfoList", getUserInfoList())
            .toString();
    }
}

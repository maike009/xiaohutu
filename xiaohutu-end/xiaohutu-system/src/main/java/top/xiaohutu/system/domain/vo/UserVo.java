package top.xiaohutu.system.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import top.xiaohutu.common.core.domain.entity.SysUser;

import java.util.Date;

public class UserVo extends SysUser {

    // 用户简介
    private String bio;
    // 总点赞数
    private int totalLikes;
    // 粉丝数量
    private int followingUserCount;
    // 粉丝的ids
    private String followingUserIds;
    // 关注的人数
    private int followerCount;

    public String getFollowingUserIds() {
        return followingUserIds;
    }

    public void setFollowingUserIds(String followingUserIds) {
        this.followingUserIds = followingUserIds;
    }

    public String getFollowerIds() {
        return followerIds;
    }

    public void setFollowerIds(String followerIds) {
        this.followerIds = followerIds;
    }

    // 关注的人的ids
    private String followerIds;


    public int getFollowingUserCount() {
        return followingUserCount;
    }

    public void setFollowingUserCount(int followingUserCount) {
        this.followingUserCount = followingUserCount;
    }

    public int getFollowerCount() {
        return followerCount;
    }

    public void setFollowerCount(int followerCount) {
        this.followerCount = followerCount;
    }

    // 出生日期
    @JsonFormat(pattern = "yyyy-MM-dd")
    private Date birthDate;
    // 地址
    private String addr;

    private String backgroundImage;

    public String getBackgroundImage() {
        return backgroundImage;
    }

    public void setBackgroundImage(String backgroundImage) {
        this.backgroundImage = backgroundImage;
    }

    // Getters and Setters
    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public int getTotalLikes() {
        return totalLikes;
    }

    public void setTotalLikes(int totalLikes) {
        this.totalLikes = totalLikes;
    }



    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

}



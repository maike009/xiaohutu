package top.xiaohutu.common.core.domain.model;

/**
 * 用户注册对象
 * 
 * @author ruoyi
 */

public class RegisterBody extends LoginBody
{

    private String nickname;
    private String sex;

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Override
    public String toString() {
        return "RegisterBody{" +
                "nickname='" + nickname + '\'' +
                ", sex='" + sex + '\'' +
                '}';
    }
}

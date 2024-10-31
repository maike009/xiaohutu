package top.xiaohutu.user.domain.model;

import lombok.Data;

@Data
public class LoginUserDTO {
    private String userName;
    private String password;
    private String code;
    private String uuid;
}

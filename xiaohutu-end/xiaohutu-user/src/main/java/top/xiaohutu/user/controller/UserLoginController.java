package top.xiaohutu.user.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import top.xiaohutu.common.constant.Constants;
import top.xiaohutu.common.core.domain.AjaxResult;
import top.xiaohutu.common.core.domain.entity.SysMenu;
import top.xiaohutu.common.core.domain.entity.SysUser;
import top.xiaohutu.common.core.domain.model.LoginBody;
import top.xiaohutu.common.utils.SecurityUtils;
import top.xiaohutu.framework.web.service.SysLoginService;
import top.xiaohutu.framework.web.service.SysPermissionService;
import top.xiaohutu.system.service.ISysMenuService;
import top.xiaohutu.user.domain.model.FrontLoginUser;
import top.xiaohutu.user.domain.model.LoginUserDTO;
import top.xiaohutu.user.service.UserLoginService;

import java.util.List;
import java.util.Set;

/**
 * 用户登录处理
 */
@RestController
@RequestMapping
public class UserLoginController {

    @Autowired
    private UserLoginService userLoginService;
    @PostMapping("/frontLogin") // 前台用户登录接口
    public AjaxResult frontLogin(@RequestBody LoginUserDTO loginBody) {
        AjaxResult ajax = AjaxResult.success();
        // 生成令牌
        String token = userLoginService.login(loginBody.getUserName(), loginBody.getPassword(), loginBody.getCode(),
                loginBody.getUuid());
        ajax.put(Constants.TOKEN, token);
        return ajax;
    }
}

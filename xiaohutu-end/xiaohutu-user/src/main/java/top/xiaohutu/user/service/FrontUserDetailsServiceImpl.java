package top.xiaohutu.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import top.xiaohutu.user.domain.User;
import top.xiaohutu.user.domain.model.FrontLoginUser;

@Service("frontUserDetailsServiceImpl")
public class FrontUserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private IUserService frontUserService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User frontUser = frontUserService.selectUserByName(username);
        if (frontUser == null) {
            throw new UsernameNotFoundException("用户不存在！");
        }
        return new FrontLoginUser(frontUser); // 使用前台用户的信息创建FrontLoginUser对象
    }

}

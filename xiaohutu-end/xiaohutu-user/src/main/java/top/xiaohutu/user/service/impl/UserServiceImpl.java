package top.xiaohutu.user.service.impl;

import java.util.List;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import top.xiaohutu.common.utils.StringUtils;
import org.springframework.transaction.annotation.Transactional;
import top.xiaohutu.user.domain.UserInfo;
import top.xiaohutu.user.mapper.UserMapper;
import top.xiaohutu.user.domain.User;
import top.xiaohutu.user.service.IUserService;

/**
 * 前台用户管理Service业务层处理
 * 
 * @author maike
 * @date 2024-10-28
 */
@Service
public class UserServiceImpl implements IUserService 
{
    @Autowired
    private UserMapper userMapper;

    /**
     * 查询前台用户管理
     * 
     * @param id 前台用户管理主键
     * @return 前台用户管理
     */
    @Override
    public User selectUserById(Long id)
    {
        return userMapper.selectUserById(id);
    }

    /**
     * 查询前台用户管理列表
     * 
     * @param user 前台用户管理
     * @return 前台用户管理
     */
    @Override
    public List<User> selectUserList(User user)
    {
        return userMapper.selectUserList(user);
    }

    /**
     * 新增前台用户管理
     * 
     * @param user 前台用户管理
     * @return 结果
     */
    @Transactional
    @Override
    public int insertUser(User user)
    {
        user.setCreateTime(DateUtils.getNowDate());
        int rows = userMapper.insertUser(user);
        insertUserInfo(user);
        return rows;
    }

    /**
     * 修改前台用户管理
     * 
     * @param user 前台用户管理
     * @return 结果
     */
    @Transactional
    @Override
    public int updateUser(User user)
    {
        user.setUpdateTime(DateUtils.getNowDate());
        userMapper.deleteUserInfoByUserId(user.getId());
        insertUserInfo(user);
        return userMapper.updateUser(user);
    }

    /**
     * 批量删除前台用户管理
     * 
     * @param ids 需要删除的前台用户管理主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteUserByIds(Long[] ids)
    {
        userMapper.deleteUserInfoByUserIds(ids);
        return userMapper.deleteUserByIds(ids);
    }

    /**
     * 删除前台用户管理信息
     * 
     * @param id 前台用户管理主键
     * @return 结果
     */
    @Transactional
    @Override
    public int deleteUserById(Long id)
    {
        userMapper.deleteUserInfoByUserId(id);
        return userMapper.deleteUserById(id);
    }

    /**
     * 新增用户详情信息
     * 
     * @param user 前台用户管理对象
     */
    public void insertUserInfo(User user)
    {
        List<UserInfo> userInfoList = user.getUserInfoList();
        Long id = user.getId();
        if (StringUtils.isNotNull(userInfoList))
        {
            List<UserInfo> list = new ArrayList<UserInfo>();
            for (UserInfo userInfo : userInfoList)
            {
                userInfo.setUserId(id);
                list.add(userInfo);
            }
            if (list.size() > 0)
            {
                userMapper.batchUserInfo(list);
            }
        }
    }
}

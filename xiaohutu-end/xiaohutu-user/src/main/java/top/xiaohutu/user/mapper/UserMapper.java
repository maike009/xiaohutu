package top.xiaohutu.user.mapper;

import java.util.List;
import top.xiaohutu.user.domain.User;
import top.xiaohutu.user.domain.UserInfo;

/**
 * 前台用户管理Mapper接口
 * 
 * @author maike
 * @date 2024-10-28
 */
public interface UserMapper 
{
    /**
     * 查询前台用户管理
     * 
     * @param id 前台用户管理主键
     * @return 前台用户管理
     */
    public User selectUserById(Long id);

    /**
     * 查询前台用户管理列表
     * 
     * @param user 前台用户管理
     * @return 前台用户管理集合
     */
    public List<User> selectUserList(User user);

    /**
     * 新增前台用户管理
     * 
     * @param user 前台用户管理
     * @return 结果
     */
    public int insertUser(User user);

    /**
     * 修改前台用户管理
     * 
     * @param user 前台用户管理
     * @return 结果
     */
    public int updateUser(User user);

    /**
     * 删除前台用户管理
     * 
     * @param id 前台用户管理主键
     * @return 结果
     */
    public int deleteUserById(Long id);

    /**
     * 批量删除前台用户管理
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteUserByIds(Long[] ids);

    /**
     * 批量删除用户详情
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteUserInfoByUserIds(Long[] ids);
    
    /**
     * 批量新增用户详情
     * 
     * @param userInfoList 用户详情列表
     * @return 结果
     */
    public int batchUserInfo(List<UserInfo> userInfoList);
    

    /**
     * 通过前台用户管理主键删除用户详情信息
     * 
     * @param id 前台用户管理ID
     * @return 结果
     */
    public int deleteUserInfoByUserId(Long id);

    User selectUserByName(String username);
}

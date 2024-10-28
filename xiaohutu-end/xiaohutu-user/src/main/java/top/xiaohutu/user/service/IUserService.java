package top.xiaohutu.user.service;

import java.util.List;
import top.xiaohutu.user.domain.User;

/**
 * 前台用户管理Service接口
 * 
 * @author maike
 * @date 2024-10-28
 */
public interface IUserService 
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
     * 批量删除前台用户管理
     * 
     * @param ids 需要删除的前台用户管理主键集合
     * @return 结果
     */
    public int deleteUserByIds(Long[] ids);

    /**
     * 删除前台用户管理信息
     * 
     * @param id 前台用户管理主键
     * @return 结果
     */
    public int deleteUserById(Long id);
}

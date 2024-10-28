package top.xiaohutu.user.mapper;

import java.util.List;
import top.xiaohutu.user.domain.UserInfo;

/**
 * 用户详情Mapper接口
 * 
 * @author maike
 * @date 2024-10-28
 */
public interface UserInfoMapper 
{
    /**
     * 查询用户详情
     * 
     * @param id 用户详情主键
     * @return 用户详情
     */
    public UserInfo selectUserInfoById(Long id);

    /**
     * 查询用户详情列表
     * 
     * @param userInfo 用户详情
     * @return 用户详情集合
     */
    public List<UserInfo> selectUserInfoList(UserInfo userInfo);

    /**
     * 新增用户详情
     * 
     * @param userInfo 用户详情
     * @return 结果
     */
    public int insertUserInfo(UserInfo userInfo);

    /**
     * 修改用户详情
     * 
     * @param userInfo 用户详情
     * @return 结果
     */
    public int updateUserInfo(UserInfo userInfo);

    /**
     * 删除用户详情
     * 
     * @param id 用户详情主键
     * @return 结果
     */
    public int deleteUserInfoById(Long id);

    /**
     * 批量删除用户详情
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteUserInfoByIds(Long[] ids);
}

package top.xiaohutu.post.service;

import java.util.List;
import top.xiaohutu.post.domain.Follower;

/**
 * 关注功能Service接口
 * 
 * @author maike
 * @date 2024-11-11
 */
public interface IFollowerService 
{
    /**
     * 查询关注功能
     * 
     * @param userId 关注功能主键
     * @return 关注功能
     */
    public Follower selectFollowerByUserId(Long userId);

    /**
     * 查询关注功能列表
     * 
     * @param follower 关注功能
     * @return 关注功能集合
     */
    public List<Follower> selectFollowerList(Follower follower);

    /**
     * 新增关注功能
     * 
     * @param follower 关注功能
     * @return 结果
     */
    public int insertFollower(Follower follower);

    /**
     * 修改关注功能
     * 
     * @param follower 关注功能
     * @return 结果
     */
    public int updateFollower(Follower follower);

    /**
     * 批量删除关注功能
     * 
     * @param followerId 需要删除的关注功能主键集合
     * @return 结果
     */
    public int deleteFollowerByUserIds(Long followerId);

    /**
     * 删除关注功能信息
     * 
     * @param userId 关注功能主键
     * @return 结果
     */
    public int deleteFollowerByUserId(Long userId);
}

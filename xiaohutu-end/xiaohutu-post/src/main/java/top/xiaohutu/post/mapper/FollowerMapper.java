package top.xiaohutu.post.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import top.xiaohutu.post.domain.Follower;

/**
 * 关注功能Mapper接口
 * 
 * @author maike
 * @date 2024-11-11
 */
public interface FollowerMapper 
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
     * 删除关注功能
     * 
     * @param userId 关注功能主键
     * @return 结果
     */
    public int deleteFollowerByUserId(@Param("userId") Long userId,@Param("followerId") Long followerId);

    /**
     * 批量删除关注功能
     * 
     * @param followerIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteFollowerByUserIds(Long[] followerIds);
}

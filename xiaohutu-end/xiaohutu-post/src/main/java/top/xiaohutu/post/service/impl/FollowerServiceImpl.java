package top.xiaohutu.post.service.impl;

import java.util.List;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.xiaohutu.common.utils.SecurityUtils;
import top.xiaohutu.post.mapper.FollowerMapper;
import top.xiaohutu.post.domain.Follower;
import top.xiaohutu.post.service.IFollowerService;

/**
 * 关注功能Service业务层处理
 * 
 * @author maike
 * @date 2024-11-11
 */
@Service
public class FollowerServiceImpl implements IFollowerService 
{
    @Autowired
    private FollowerMapper followerMapper;

    /**
     * 查询关注功能
     * 
     * @param userId 关注功能主键
     * @return 关注功能
     */
    @Override
    public Follower selectFollowerByUserId(Long userId)
    {
        return followerMapper.selectFollowerByUserId(userId);
    }

    /**
     * 查询关注功能列表
     * 
     * @param follower 关注功能
     * @return 关注功能
     */
    @Override
    public List<Follower> selectFollowerList(Follower follower)
    {
        return followerMapper.selectFollowerList(follower);
    }

    /**
     * 新增关注功能
     * 
     * @param follower 关注功能
     * @return 结果
     */
    @Override
    public int insertFollower(Follower follower)
    {
        follower.setCreateTime(DateUtils.getNowDate());
        follower.setUserId(SecurityUtils.getUserId());
        return followerMapper.insertFollower(follower);
    }

    /**
     * 修改关注功能
     * 
     * @param follower 关注功能
     * @return 结果
     */
    @Override
    public int updateFollower(Follower follower)
    {
        follower.setUpdateTime(DateUtils.getNowDate());
        return followerMapper.updateFollower(follower);
    }

    /**
     * 批量删除关注功能
     * 
     * @param followerId 需要删除的关注功能主键
     * @return 结果
     */
    @Override
    public int deleteFollowerByUserIds(Long followerId)
    {
        Long userId = SecurityUtils.getUserId();
        return followerMapper.deleteFollowerByUserId(userId,followerId);
    }

    /**
     * 删除关注功能信息
     * 
     * @param followerId 关注功能主键
     * @return 结果
     */
    @Override
    public int deleteFollowerByUserId(Long followerId)
    {
        Long userId = SecurityUtils.getUserId();
        return followerMapper.deleteFollowerByUserId(userId,followerId);
    }
}

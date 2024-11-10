package top.xiaohutu.post.service.impl;

import java.util.List;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.xiaohutu.post.mapper.UserLikeMapper;
import top.xiaohutu.post.domain.UserLike;
import top.xiaohutu.post.service.IUserLikeService;

/**
 * 点赞Service业务层处理
 * 
 * @author maike
 * @date 2024-11-09
 */
@Service
public class UserLikeServiceImpl implements IUserLikeService 
{
    @Autowired
    private UserLikeMapper userLikeMapper;

    /**
     * 查询点赞
     * 
     * @param userId 点赞主键
     * @return 点赞
     */
    @Override
    public UserLike selectUserLikeByUserId(Long userId)
    {
        return userLikeMapper.selectUserLikeByUserId(userId);
    }

    /**
     * 查询点赞列表
     * 
     * @param userLike 点赞
     * @return 点赞
     */
    @Override
    public List<UserLike> selectUserLikeList(UserLike userLike)
    {
        return userLikeMapper.selectUserLikeList(userLike);
    }

    /**
     * 新增点赞
     * 
     * @param userLike 点赞
     * @return 结果
     */
    @Override
    public int insertUserLike(UserLike userLike)
    {
        userLike.setCreateTime(DateUtils.getNowDate());

        return userLikeMapper.insertUserLike(userLike);
    }

    /**
     * 修改点赞
     * 
     * @param userLike 点赞
     * @return 结果
     */
    @Override
    public int updateUserLike(UserLike userLike)
    {
        userLike.setUpdateTime(DateUtils.getNowDate());
        return userLikeMapper.updateUserLike(userLike);
    }

    /**
     * 批量删除点赞
     * 
     * @param userLike 需要删除的点赞主键
     * @return 结果
     */
    @Override
    public int deleteUserLikeByUserIds(UserLike userLike)
    {
        return userLikeMapper.deleteUserLikeByUserIds(userLike);
    }

    /**
     * 删除点赞信息
     * 
     * @param userId 点赞主键
     * @return 结果
     */
    @Override
    public int deleteUserLikeByUserId(Long userId)
    {
        return userLikeMapper.deleteUserLikeByUserId(userId);
    }
}

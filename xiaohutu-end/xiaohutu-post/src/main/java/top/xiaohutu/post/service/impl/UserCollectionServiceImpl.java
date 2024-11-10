package top.xiaohutu.post.service.impl;

import java.util.List;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.xiaohutu.post.mapper.UserCollectionMapper;
import top.xiaohutu.post.domain.UserCollection;
import top.xiaohutu.post.service.IUserCollectionService;

/**
 * 收藏Service业务层处理
 * 
 * @author maike
 * @date 2024-11-09
 */
@Service
public class UserCollectionServiceImpl implements IUserCollectionService 
{
    @Autowired
    private UserCollectionMapper userCollectionMapper;

    /**
     * 查询收藏
     * 
     * @param userId 收藏主键
     * @return 收藏
     */
    @Override
    public UserCollection selectUserCollectionByUserId(Long userId)
    {
        return userCollectionMapper.selectUserCollectionByUserId(userId);
    }

    /**
     * 查询收藏列表
     * 
     * @param userCollection 收藏
     * @return 收藏
     */
    @Override
    public List<UserCollection> selectUserCollectionList(UserCollection userCollection)
    {
        return userCollectionMapper.selectUserCollectionList(userCollection);
    }

    /**
     * 新增收藏
     * 
     * @param userCollection 收藏
     * @return 结果
     */
    @Override
    public int insertUserCollection(UserCollection userCollection)
    {
        userCollection.setCreateTime(DateUtils.getNowDate());
        return userCollectionMapper.insertUserCollection(userCollection);
    }

    /**
     * 修改收藏
     * 
     * @param userCollection 收藏
     * @return 结果
     */
    @Override
    public int updateUserCollection(UserCollection userCollection)
    {
        userCollection.setUpdateTime(DateUtils.getNowDate());
        return userCollectionMapper.updateUserCollection(userCollection);
    }

    /**
     * 批量删除收藏
     * 
     * @param userIds 需要删除的收藏主键
     * @return 结果
     */
    @Override
    public int deleteUserCollectionByUserIds(UserCollection userCollection)
    {
        return userCollectionMapper.deleteUserCollectionByUserIds( userCollection);
    }

    /**
     * 删除收藏信息
     * 
     * @param userId 收藏主键
     * @return 结果
     */
    @Override
    public int deleteUserCollectionByUserId(Long userId)
    {
        return userCollectionMapper.deleteUserCollectionByUserId(userId);
    }
}

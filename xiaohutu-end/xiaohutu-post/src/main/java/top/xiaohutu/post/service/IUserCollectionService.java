package top.xiaohutu.post.service;

import java.util.List;
import top.xiaohutu.post.domain.UserCollection;

/**
 * 收藏Service接口
 * 
 * @author maike
 * @date 2024-11-09
 */
public interface IUserCollectionService 
{
    /**
     * 查询收藏
     * 
     * @param userId 收藏主键
     * @return 收藏
     */
    public UserCollection selectUserCollectionByUserId(Long userId);

    /**
     * 查询收藏列表
     * 
     * @param userCollection 收藏
     * @return 收藏集合
     */
    public List<UserCollection> selectUserCollectionList(UserCollection userCollection);

    /**
     * 新增收藏
     * 
     * @param userCollection 收藏
     * @return 结果
     */
    public int insertUserCollection(UserCollection userCollection);

    /**
     * 修改收藏
     * 
     * @param userCollection 收藏
     * @return 结果
     */
    public int updateUserCollection(UserCollection userCollection);

    /**
     * 批量删除收藏
     * 
     * @param userIds 需要删除的收藏主键集合
     * @return 结果
     */
    public int deleteUserCollectionByUserIds(UserCollection userCollection);

    /**
     * 删除收藏信息
     * 
     * @param userId 收藏主键
     * @return 结果
     */
    public int deleteUserCollectionByUserId(Long userId);
}

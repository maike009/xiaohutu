package top.xiaohutu.post.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import top.xiaohutu.post.domain.UserCollection;

/**
 * 收藏Mapper接口
 * 
 * @author maike
 * @date 2024-11-09
 */
public interface UserCollectionMapper 
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
     * 删除收藏
     * 
     * @param userId 收藏主键
     * @return 结果
     */
    public int deleteUserCollectionByUserId(Long userId);

    /**
     * 批量删除收藏
     * 
     * @param userCollection 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteUserCollectionByUserIds(UserCollection userCollection);

    UserCollection selectUserCollectionByUserIdAndPostId(@Param("userId") Long userId, @Param("postId") Long postId);
}

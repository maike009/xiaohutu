package top.xiaohutu.post.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import top.xiaohutu.post.domain.UserLike;

/**
 * 点赞Mapper接口
 * 
 * @author maike
 * @date 2024-11-09
 */
public interface UserLikeMapper 
{
    /**
     * 查询点赞
     * 
     * @param userId 点赞主键
     * @return 点赞
     */
    public UserLike selectUserLikeByUserId(Long userId);

    /**
     * 查询点赞列表
     * 
     * @param userLike 点赞
     * @return 点赞集合
     */
    public List<UserLike> selectUserLikeList(UserLike userLike);

    /**
     * 新增点赞
     * 
     * @param userLike 点赞
     * @return 结果
     */
    public int insertUserLike(UserLike userLike);

    /**
     * 修改点赞
     * 
     * @param userLike 点赞
     * @return 结果
     */
    public int updateUserLike(UserLike userLike);

    /**
     * 删除点赞
     * 
     * @param userId 点赞主键
     * @return 结果
     */
    public int deleteUserLikeByUserId(Long userId);

    /**
     * 批量删除点赞
     * 
     * @param userLike 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteUserLikeByUserIds(UserLike userLike);

    UserLike selectUserLikeByUserIdAndPostId(@Param("userId") Long userId,@Param("postId") Long postId);
}

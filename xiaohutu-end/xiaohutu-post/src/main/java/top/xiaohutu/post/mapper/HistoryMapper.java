package top.xiaohutu.post.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import top.xiaohutu.post.domain.History;

/**
 * 历史记录Mapper接口
 * 
 * @author maike
 * @date 2024-11-11
 */
public interface HistoryMapper 
{
    /**
     * 查询历史记录
     * 
     * @param history 历史记录主键
     * @return 历史记录
     */
    public History selectHistoryByUserId(History history);

    /**
     * 查询历史记录列表
     * 
     * @param history 历史记录
     * @return 历史记录集合
     */
    public List<History> selectHistoryList(History history);

    /**
     * 新增历史记录
     * 
     * @param history 历史记录
     * @return 结果
     */
    public int insertHistory(History history);

    /**
     * 修改历史记录
     * 
     * @param history 历史记录
     * @return 结果
     */
    public int updateHistory(History history);

    /**
     * 删除历史记录
     * 
     * @param userId 历史记录主键
     * @return 结果
     */
    public int deleteHistoryByUserId(Long userId);

    /**
     * 批量删除历史记录
     * 
     * @param userIds 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteHistoryByUserIds(@Param("array") Long[] userIds,@Param("userId") Long userId);
}

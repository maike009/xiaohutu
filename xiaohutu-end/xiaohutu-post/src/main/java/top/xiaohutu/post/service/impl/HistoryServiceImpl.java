package top.xiaohutu.post.service.impl;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.xiaohutu.common.utils.SecurityUtils;
import top.xiaohutu.post.mapper.HistoryMapper;
import top.xiaohutu.post.domain.History;
import top.xiaohutu.post.service.IHistoryService;

/**
 * 历史记录Service业务层处理
 * 
 * @author maike
 * @date 2024-11-11
 */
@Service
public class HistoryServiceImpl implements IHistoryService 
{
    @Autowired
    private HistoryMapper historyMapper;

    /**
     * 查询历史记录
     * 
     * @param userId 历史记录主键
     * @return 历史记录
     */
    @Override
    public History selectHistoryByUserId(Long userId)
    {
        return null;
    }

    /**
     * 查询历史记录列表
     * 
     * @param history 历史记录
     * @return 历史记录
     */
    @Override
    public List<History> selectHistoryList(History history)
    {
        return historyMapper.selectHistoryList(history);
    }

    /**
     * 新增历史记录
     * 
     * @param history 历史记录
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public int insertHistory(History history)
    {
        history.setCreateTime(DateUtils.getNowDate());
        history.setUserId(SecurityUtils.getUserId());
        // 如果当前历史记录存在新删除在新增
        History isExit = historyMapper.selectHistoryByUserId(history);
        if (isExit!=null){
            return this.updateHistory(history);
        }
        return historyMapper.insertHistory(history);
    }

    /**
     * 修改历史记录
     * 
     * @param history 历史记录
     * @return 结果
     */
    @Override
    public int updateHistory(History history)
    {
        history.setUpdateTime(DateUtils.getNowDate());
        return historyMapper.updateHistory(history);
    }

    /**
     * 批量删除历史记录
     * 
     * @param userIds 需要删除的历史记录主键
     * @return 结果
     */
    @Override
    public int deleteHistoryByUserIds(Long[] userIds)
    {
        Long userId = SecurityUtils.getUserId();
        return historyMapper.deleteHistoryByUserIds(userIds,userId);
    }

    /**
     * 删除历史记录信息
     * 
     * @param userId 历史记录主键
     * @return 结果
     */
    @Override
    public int deleteHistoryByUserId(Long userId)
    {
        return historyMapper.deleteHistoryByUserId(userId);
    }
}

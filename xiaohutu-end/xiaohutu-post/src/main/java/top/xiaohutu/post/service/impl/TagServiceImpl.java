package top.xiaohutu.post.service.impl;

import java.util.List;
import top.xiaohutu.common.utils.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.xiaohutu.post.mapper.TagMapper;
import top.xiaohutu.post.domain.Tag;
import top.xiaohutu.post.service.ITagService;

/**
 * 标签（分类）Service业务层处理
 * 
 * @author maike
 * @date 2024-11-07
 */
@Service
public class TagServiceImpl implements ITagService 
{
    @Autowired
    private TagMapper tagMapper;

    /**
     * 查询标签（分类）
     * 
     * @param id 标签（分类）主键
     * @return 标签（分类）
     */
    @Override
    public Tag selectTagById(Long id)
    {
        return tagMapper.selectTagById(id);
    }

    /**
     * 查询标签（分类）列表
     * 
     * @param tag 标签（分类）
     * @return 标签（分类）
     */
    @Override
    public List<Tag> selectTagList(Tag tag)
    {
        return tagMapper.selectTagList(tag);
    }

    /**
     * 新增标签（分类）
     * 
     * @param tag 标签（分类）
     * @return 结果
     */
    @Override
    public int insertTag(Tag tag)
    {
        tag.setCreateTime(DateUtils.getNowDate());
        return tagMapper.insertTag(tag);
    }

    /**
     * 修改标签（分类）
     * 
     * @param tag 标签（分类）
     * @return 结果
     */
    @Override
    public int updateTag(Tag tag)
    {
        tag.setUpdateTime(DateUtils.getNowDate());
        return tagMapper.updateTag(tag);
    }

    /**
     * 批量删除标签（分类）
     * 
     * @param ids 需要删除的标签（分类）主键
     * @return 结果
     */
    @Override
    public int deleteTagByIds(Long[] ids)
    {
        return tagMapper.deleteTagByIds(ids);
    }

    /**
     * 删除标签（分类）信息
     * 
     * @param id 标签（分类）主键
     * @return 结果
     */
    @Override
    public int deleteTagById(Long id)
    {
        return tagMapper.deleteTagById(id);
    }
}

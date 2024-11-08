package top.xiaohutu.post.mapper;

import java.util.List;
import top.xiaohutu.post.domain.Tag;

/**
 * 标签（分类）Mapper接口
 * 
 * @author maike
 * @date 2024-11-07
 */
public interface TagMapper 
{
    /**
     * 查询标签（分类）
     * 
     * @param id 标签（分类）主键
     * @return 标签（分类）
     */
    public Tag selectTagById(Long id);

    /**
     * 查询标签（分类）列表
     * 
     * @param tag 标签（分类）
     * @return 标签（分类）集合
     */
    public List<Tag> selectTagList(Tag tag);

    /**
     * 新增标签（分类）
     * 
     * @param tag 标签（分类）
     * @return 结果
     */
    public int insertTag(Tag tag);

    /**
     * 修改标签（分类）
     * 
     * @param tag 标签（分类）
     * @return 结果
     */
    public int updateTag(Tag tag);

    /**
     * 删除标签（分类）
     * 
     * @param id 标签（分类）主键
     * @return 结果
     */
    public int deleteTagById(Long id);

    /**
     * 批量删除标签（分类）
     * 
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    public int deleteTagByIds(Long[] ids);
}

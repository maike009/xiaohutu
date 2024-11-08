package top.xiaohutu.post.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import top.xiaohutu.common.annotation.Excel;
import top.xiaohutu.common.core.domain.BaseEntity;

/**
 * 标签（分类）对象 tb_tag
 * 
 * @author maike
 * @date 2024-11-07
 */
public class Tag extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 标签id */
    @Excel(name = "标签id")
    private Long id;

    /** 标签内容 */
    @Excel(name = "标签内容")
    private String tagContent;

    /** 标签使用数量 */
    @Excel(name = "标签使用数量")
    private Long count;

    public void setId(Long id) 
    {
        this.id = id;
    }

    public Long getId() 
    {
        return id;
    }
    public void setTagContent(String tagContent) 
    {
        this.tagContent = tagContent;
    }

    public String getTagContent() 
    {
        return tagContent;
    }
    public void setCount(Long count) 
    {
        this.count = count;
    }

    public Long getCount() 
    {
        return count;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("tagContent", getTagContent())
            .append("count", getCount())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .toString();
    }
}

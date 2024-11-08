package top.xiaohutu.post.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
@TableName("tb_post_tag")
public class PostTag {
    @TableField(value = "post_id")
    private Long postId;
    @TableField(value = "tag_id")
    private Long tagId;
}

package top.xiaohutu.post.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;
import top.xiaohutu.common.core.domain.BaseEntity;

@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class PostTag extends BaseEntity {
    private Long postId;
    private Long tagId;
}

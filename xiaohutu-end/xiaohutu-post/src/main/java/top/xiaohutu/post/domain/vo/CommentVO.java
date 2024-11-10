package top.xiaohutu.post.domain.vo;

import lombok.Data;
import top.xiaohutu.post.domain.Comment;

@Data
public class CommentVO extends Comment {
    private String userName;
    private String nickName;
    private String avatar;
}

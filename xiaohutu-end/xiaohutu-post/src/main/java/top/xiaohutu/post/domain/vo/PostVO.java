package top.xiaohutu.post.domain.vo;

import lombok.Data;
import top.xiaohutu.post.domain.Post;

@Data
public class PostVO extends Post {
    private String userName;
    private String nickName;
    private String addr;
    private String tagContent;
    private String avatar;

}

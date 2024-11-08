package top.xiaohutu.post.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import top.xiaohutu.post.domain.PostTag;

import java.util.List;

@Mapper
public interface PostTagMapper {
    void saveBatch(List<PostTag> postTags);
}

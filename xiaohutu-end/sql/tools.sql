create table if not exists xiaohutu.tb_post
(
    id             bigint auto_increment comment '帖子ID'
    primary key,
    user_id        bigint                 null comment '用户ID(连接用户表的id)',
    content_text   text                   null comment '文本内容',
    content_image  varchar(3000)          null comment '图片地址',
    like_count     int         default 0  null comment '点赞数',
    comment_count  int         default 0  null comment '评论数',
    tag_id         bigint                 null comment '标签',
    address        varchar(200)           null comment '发布位置',
    is_public      tinyint(1)  default 0  null comment '是否公开(0代表公开，1是私密)',
    favorite_count int         default 0  null comment '收藏数量',
    draft_status   int         default 1  null comment '草稿状态（0是正常，1是草稿）',
    status         int         default 1  null comment '帖子状态（0：正常，1：审核未通过）',
    create_by      varchar(64) default '' null comment '创建者',
    create_time    datetime               null comment '创建时间',
    update_by      varchar(64) default '' null comment '更新者',
    update_time    datetime               null comment '更新时间'
    )
    comment '帖子表';

create fulltext index idx_full_content
    on xiaohutu.tb_post (content_text);
# 帖子视图
drop view post_user_view;
create view post_user_view as
select u.user_name,u.avatar,u.nick_name,group_concat(t.tag_content) as tag_content,IFNULL(a.city,'未知') as addr,
       (select count(*) from tb_user_like tul where tul.post_id = p.id ) as like_count,
       (select count(*) from tb_user_collection tuc where tuc.post_id = p.id ) as favorite_count,
       (select count(*) from  comment c where c.post_id = p.id ) as comment_count,
       p.id,p.user_id,p.tag_id,p.address_id,p.content_text,p.content_image,p.post_title,p.create_by,p.update_by,
       p.is_public,p.create_time,p.update_time,p.draft_status,p.status from tb_post p
                                                                                left join sys_user u on u.user_id = p.user_id
                                                                                left join addresses a on a.address_id = p.address_id
                                                                                left join tb_post_tag pt on pt.post_id = p.id
                                                                                left join tb_tag t on t.id = pt.tag_id
group by p.id ;
# 评论视图
drop view comment_view;
create view comment_view as
select c.*,su.nick_name,su.user_name,su.avatar
from comment c left join sys_user su on c.user_id = su.user_id;
# 用户视图
drop view user_info_view;
create view user_info_view as
SELECT
    u.*,
    info.bio,
    COUNT(DISTINCT tul.user_id) AS total_likes,
    info.background_image,
    info.birth_date,
    MAX(CONCAT(a.province, ' ', a.city)) AS addr,

    -- 当前用户关注的人
    GROUP_CONCAT(DISTINCT tf.follower_id ORDER BY tf.follower_id ASC SEPARATOR ',') AS follower_ids,
    COUNT(DISTINCT tf.follower_id) AS follower_count,

    -- 关注当前用户的粉丝
    GROUP_CONCAT(DISTINCT tf2.user_id ORDER BY tf2.user_id ASC SEPARATOR ',') AS following_user_ids,
    COUNT(DISTINCT tf2.user_id) AS following_user_count

FROM
    sys_user u
        LEFT JOIN
    tb_user_info info ON u.user_id = info.user_id
        LEFT JOIN
    tb_post tp ON u.user_id = tp.user_id
        LEFT JOIN
    addresses a ON info.address_id = a.address_id
        LEFT JOIN
    tb_user_like tul ON tp.id = tul.post_id

-- 关联粉丝表，获取当前用户关注的粉丝信息
        LEFT JOIN
    tb_follower tf ON u.user_id = tf.user_id

-- 关联粉丝表的另一个实例，用于查询关注当前用户的粉丝信息
        LEFT JOIN
    tb_follower tf2 ON u.user_id = tf2.follower_id

GROUP BY
    u.user_id,
    info.bio,
    info.followers_count,
    info.following_count,
    info.birth_date,
    info.background_image,
    info.address_id;
# 查询用户的粉丝
# select group_concat(tf.follower_id separator ',') from sys_user u,tb_follower tf where u.user_id = tf.user_id group by u.user_id

select u.user_name,u.user_id,count(tul.user_id) as totallikes
from tb_post tp,sys_user u,tb_user_like tul
where u.user_id = tp.user_id and tp.id = tul.post_id group by u.user_id


    # 查询用户粉丝和用户的关注的列表，查哪个连哪个的id
select uiv.user_id, dept_id,background_image, user_name, nick_name, user_type, email, phonenumber, sex,
       avatar, password, status, del_flag, login_ip, login_date, create_by, tf.create_time,
       update_by, tf.update_time, remark, bio, total_likes, follower_count,follower_ids,following_user_count,following_user_ids,
       birth_date, addr
from user_info_view uiv join tb_follower tf on tf.user_id=uiv.user_id
where tf.follower_id=1
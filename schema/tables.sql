-- ----------------------------
-- Table structure for bilibili_video
-- ----------------------------
DROP TABLE IF EXISTS bilibili_video;
CREATE TABLE bilibili_video (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    video_id varchar(64) NOT NULL,
    video_type varchar(16) NOT NULL,
    title varchar(500) DEFAULT NULL,
    "desc" text,
    create_time bigint NOT NULL,
    liked_count varchar(16) DEFAULT NULL,
    disliked_count varchar(16) DEFAULT NULL,
    video_play_count varchar(16) DEFAULT NULL,
    video_favorite_count varchar(16) DEFAULT NULL,
    video_share_count varchar(16) DEFAULT NULL,
    video_coin_count varchar(16) DEFAULT NULL,
    video_danmaku varchar(16) DEFAULT NULL,
    video_comment varchar(16) DEFAULT NULL,
    video_url varchar(512) DEFAULT NULL,
    video_cover_url varchar(512) DEFAULT NULL
);

CREATE INDEX idx_bilibili_vi_video_i_31c36e ON bilibili_video(video_id);
CREATE INDEX idx_bilibili_vi_create__73e0ec ON bilibili_video(create_time);

-- ----------------------------
-- Table structure for bilibili_video_comment
-- ----------------------------
DROP TABLE IF EXISTS bilibili_video_comment;
CREATE TABLE bilibili_video_comment (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    sex varchar(64) DEFAULT NULL,
    sign varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    comment_id varchar(64) NOT NULL,
    video_id varchar(64) NOT NULL,
    content text,
    create_time bigint NOT NULL,
    sub_comment_count varchar(16) NOT NULL
);

CREATE INDEX idx_bilibili_vi_comment_41c34e ON bilibili_video_comment(comment_id);
CREATE INDEX idx_bilibili_vi_video_i_f22873 ON bilibili_video_comment(video_id);

-- ----------------------------
-- Table structure for bilibili_up_info
-- ----------------------------
DROP TABLE IF EXISTS bilibili_up_info;
CREATE TABLE bilibili_up_info (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    sex varchar(64) DEFAULT NULL,
    sign varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    total_fans bigint DEFAULT NULL,
    total_liked bigint DEFAULT NULL,
    user_rank int DEFAULT NULL,
    is_official int DEFAULT NULL
);

CREATE INDEX idx_bilibili_vi_user_123456 ON bilibili_up_info(user_id);

-- ----------------------------
-- Table structure for douyin_aweme
-- ----------------------------
DROP TABLE IF EXISTS douyin_aweme;
CREATE TABLE douyin_aweme (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    sec_uid varchar(128) DEFAULT NULL,
    short_user_id varchar(64) DEFAULT NULL,
    user_unique_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    user_signature varchar(500) DEFAULT NULL,
    ip_location varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    aweme_id varchar(64) NOT NULL,
    aweme_type varchar(16) NOT NULL,
    title varchar(500) DEFAULT NULL,
    "desc" text,
    create_time bigint NOT NULL,
    liked_count varchar(16) DEFAULT NULL,
    comment_count varchar(16) DEFAULT NULL,
    share_count varchar(16) DEFAULT NULL,
    collected_count varchar(16) DEFAULT NULL,
    aweme_url varchar(255) DEFAULT NULL
);

CREATE INDEX idx_douyin_awem_aweme_i_6f7bc6 ON douyin_aweme(aweme_id);
CREATE INDEX idx_douyin_awem_create__299dfe ON douyin_aweme(create_time);

-- ----------------------------
-- Table structure for douyin_aweme_comment
-- ----------------------------
DROP TABLE IF EXISTS douyin_aweme_comment;
CREATE TABLE douyin_aweme_comment (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    sec_uid varchar(128) DEFAULT NULL,
    short_user_id varchar(64) DEFAULT NULL,
    user_unique_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    user_signature varchar(500) DEFAULT NULL,
    ip_location varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    comment_id varchar(64) NOT NULL,
    aweme_id varchar(64) NOT NULL,
    content text,
    create_time bigint NOT NULL,
    sub_comment_count varchar(16) NOT NULL
);

CREATE INDEX idx_douyin_awem_comment_fcd7e4 ON douyin_aweme_comment(comment_id);
CREATE INDEX idx_douyin_awem_aweme_i_c50049 ON douyin_aweme_comment(aweme_id);

-- ----------------------------
-- Table structure for dy_creator
-- ----------------------------
DROP TABLE IF EXISTS dy_creator;
CREATE TABLE dy_creator (
    id SERIAL PRIMARY KEY,
    user_id varchar(128) NOT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    ip_location varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    "desc" text,
    gender varchar(1) DEFAULT NULL,
    follows varchar(16) DEFAULT NULL,
    fans varchar(16) DEFAULT NULL,
    interaction varchar(16) DEFAULT NULL,
    videos_count varchar(16) DEFAULT NULL
);

-- ----------------------------
-- Table structure for kuaishou_video
-- ----------------------------
DROP TABLE IF EXISTS kuaishou_video;
CREATE TABLE kuaishou_video (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    video_id varchar(64) NOT NULL,
    video_type varchar(16) NOT NULL,
    title varchar(500) DEFAULT NULL,
    "desc" text,
    create_time bigint NOT NULL,
    liked_count varchar(16) DEFAULT NULL,
    viewd_count varchar(16) DEFAULT NULL,
    video_url varchar(512) DEFAULT NULL,
    video_cover_url varchar(512) DEFAULT NULL,
    video_play_url varchar(512) DEFAULT NULL
);

CREATE INDEX idx_kuaishou_vi_video_i_c5c6a6 ON kuaishou_video(video_id);
CREATE INDEX idx_kuaishou_vi_create__a10dee ON kuaishou_video(create_time);

-- ----------------------------
-- Table structure for kuaishou_video_comment
-- ----------------------------
DROP TABLE IF EXISTS kuaishou_video_comment;
CREATE TABLE kuaishou_video_comment (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    comment_id varchar(64) NOT NULL,
    video_id varchar(64) NOT NULL,
    content text,
    create_time bigint NOT NULL,
    sub_comment_count varchar(16) NOT NULL
);

CREATE INDEX idx_kuaishou_vi_comment_ed48fa ON kuaishou_video_comment(comment_id);
CREATE INDEX idx_kuaishou_vi_video_i_e50914 ON kuaishou_video_comment(video_id);

-- ----------------------------
-- Table structure for weibo_note
-- ----------------------------
DROP TABLE IF EXISTS weibo_note;
CREATE TABLE weibo_note (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    gender varchar(12) DEFAULT NULL,
    profile_url varchar(255) DEFAULT NULL,
    ip_location varchar(32) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    note_id varchar(64) NOT NULL,
    content text,
    create_time bigint NOT NULL,
    create_date_time varchar(32) NOT NULL,
    liked_count varchar(16) DEFAULT NULL,
    comments_count varchar(16) DEFAULT NULL,
    shared_count varchar(16) DEFAULT NULL,
    note_url varchar(512) DEFAULT NULL
);

CREATE INDEX idx_weibo_note_note_id_f95b1a ON weibo_note(note_id);
CREATE INDEX idx_weibo_note_create__692709 ON weibo_note(create_time);
CREATE INDEX idx_weibo_note_create__d05ed2 ON weibo_note(create_date_time);

-- ----------------------------
-- Table structure for weibo_note_comment
-- ----------------------------
DROP TABLE IF EXISTS weibo_note_comment;
CREATE TABLE weibo_note_comment (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) DEFAULT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    gender varchar(12) DEFAULT NULL,
    profile_url varchar(255) DEFAULT NULL,
    ip_location varchar(32) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    comment_id varchar(64) NOT NULL,
    note_id varchar(64) NOT NULL,
    content text,
    create_time bigint NOT NULL,
    create_date_time varchar(32) NOT NULL,
    comment_like_count varchar(16) NOT NULL,
    sub_comment_count varchar(16) NOT NULL
);

CREATE INDEX idx_weibo_note__comment_c7611c ON weibo_note_comment(comment_id);
CREATE INDEX idx_weibo_note__note_id_24f108 ON weibo_note_comment(note_id);
CREATE INDEX idx_weibo_note__create__667fe3 ON weibo_note_comment(create_date_time);

-- ----------------------------
-- Table structure for xhs_creator
-- ----------------------------
DROP TABLE IF EXISTS xhs_creator;
CREATE TABLE xhs_creator (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) NOT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    ip_location varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    "desc" text,
    gender varchar(1) DEFAULT NULL,
    follows varchar(16) DEFAULT NULL,
    fans varchar(16) DEFAULT NULL,
    interaction varchar(16) DEFAULT NULL,
    tag_list text
);

-- ----------------------------
-- Table structure for xhs_note
-- ----------------------------
DROP TABLE IF EXISTS xhs_note;
CREATE TABLE xhs_note (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) NOT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    ip_location varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    note_id varchar(64) NOT NULL,
    type varchar(16) DEFAULT NULL,
    title varchar(255) DEFAULT NULL,
    "desc" text,
    video_url text,
    time bigint NOT NULL,
    last_update_time bigint NOT NULL,
    liked_count varchar(16) DEFAULT NULL,
    collected_count varchar(16) DEFAULT NULL,
    comment_count varchar(16) DEFAULT NULL,
    share_count varchar(16) DEFAULT NULL,
    image_list text,
    tag_list text,
    note_url varchar(255) DEFAULT NULL
);

CREATE INDEX idx_xhs_note_note_id_209457 ON xhs_note(note_id);
CREATE INDEX idx_xhs_note_time_eaa910 ON xhs_note(time);

-- ----------------------------
-- Table structure for xhs_note_comment
-- ----------------------------
DROP TABLE IF EXISTS xhs_note_comment;
CREATE TABLE xhs_note_comment (
    id SERIAL PRIMARY KEY,
    user_id varchar(64) NOT NULL,
    nickname varchar(64) DEFAULT NULL,
    avatar varchar(255) DEFAULT NULL,
    ip_location varchar(255) DEFAULT NULL,
    add_ts bigint NOT NULL,
    last_modify_ts bigint NOT NULL,
    comment_id varchar(64) NOT NULL,
    create_time bigint NOT NULL,
    note_id varchar(64) NOT NULL,
    content text NOT NULL,
    sub_comment_count int NOT NULL,
    pictures varchar(512) DEFAULT NULL
);

CREATE INDEX idx_xhs_note_co_comment_8e8349 ON xhs_note_comment(comment_id);
CREATE INDEX idx_xhs_note_co_create__204f8d ON xhs_note_comment(create_time);

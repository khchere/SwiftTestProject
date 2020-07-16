
import Foundation

class PostList: Codable {

    let sns_user_sn: Int?
    let user_nexon_sn: Int?
    let post_no: Int?
    let post_type: String?
    let content: String?
    let user_nick: String?
    let user_img: String?
    let user_type: String? // 성별 m or f
    let level_no: Int!
    let season_level_no: Int! = 0
    let season_level_join_flag: String?
    let read_cnt: Int?
    let comment_max_no: Int?
    let comment_create_cnt: Int!
    let comment_remove_cnt: Int!
    let recommend_create_cnt: Int!
    let recommend_remove_cnt: Int!
    let img_url: String?
    let youtube_url: String?
    let ipt_time: String?
    let upt_time: String?
    let hash_tag_1: String?
    let hash_tag_2: String?
    let hash_tag_3: String?
    let recommend_tag: String?
    let clan_no: String?
    let clan_name: String?
    let listType: String?
    let rownum: Int?
    let img_width: Int?
    let img_height: Int?
//    var Dataset2: Array<Any>?
}

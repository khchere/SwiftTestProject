//
//  PostDetailViewController.swift
//  TestProject
//
//  Created by Platform Development on 2020/07/16.
//  Copyright © 2020 Platform Development. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class PostDtailViewController: UIViewController {
    private var listlistData : [CommentData] = Array()
    @IBOutlet weak var pTableView: PagingTableView!
    
    var SNSUserSn: Int = 0
    var postNo: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pTableView.pagingDelegate = self
        pTableView.dataSource = self
        pTableView.delegate = self
    }
    
    func requestPostCommentList(pageNumber : Int) {
        print("paginate getPostList: \(pageNumber)")
        let parameters: [String: String] = ["sns_user_sn": "\(SNSUserSn)",
            "post_no": "\(postNo)",
            "pageSize": "10",
            "currentPage": "\(pageNumber)"]
        WebServiceManager.shared.callWebService(getPostCommentList, parameters: parameters, method: .post) { (response: [CommentData]?, error, errorMessage)  in
            if response != nil {
                self.listlistData.append(contentsOf: response!)
            }
            self.pTableView.reloadData()
            self.pTableView.isLoading = false
        }
    }
    
    
}


extension PostDtailViewController : UITableViewDataSource, UITableViewDelegate, PagingTableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listlistData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pTableView.dequeueReusableCell(withIdentifier: "CommentListCell", for: indexPath) as! CommentListCell
        
        let listData = self.listlistData[indexPath.row]
        
        cell.pNickNameLabel.text = listData.user_nick
        
        let url = URL(string: Utils.getProfileImage(listData.user_img, imgSize: Utils.WebImageSize.small))
        let processor = RoundCornerImageProcessor(cornerRadius: 34)
        cell.pImageView.kf.setImage(with: url, options: [.transition(.fade(0.2)), .processor(processor)])
        
        cell.pGradeImg.image = Utils.getGradeImg(oldLevelNo: listData.level_no ?? 0, seasonLevelNo: listData.season_level_no ?? 0, seasonflag: listData.season_level_join_flag, iptTime: listData.ipt_time)
        
        let dateFomat = DateFormatter()
        dateFomat.dateFormat = "yy'.'MM'.'dd"
        cell.pTimeLabel.text = Utils.convertTimeFormat(inputStr: listData.ipt_time ?? "", inputFormat: nil, outputFormat: dateFomat)
        cell.pCommentTextView.text = listData.content
        
        
        if (listData.img_url!.isEmpty){
            cell.pImageWidthConstraints.constant = 0
            cell.pImageHeightConst.constant = 0
        }

        return cell
    }
    
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
        print("paginate page: \(page)")
        pTableView.isLoading = true
        requestPostCommentList(pageNumber: page)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView didSelectRowAt : \(indexPath)")
        //        self.performSegue(withIdentifier: "DetailViewSegue", sender: nil)
    }
    
    
}

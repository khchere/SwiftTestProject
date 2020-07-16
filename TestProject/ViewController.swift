//
//  ViewController.swift
//  TestProject
//
//  Created by Platform Development on 2020/06/17.
//  Copyright © 2020 Platform Development. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

@available(iOS 13.0, *)

struct Config { static let baseURL = "https://saradioapi.nexon.com" }

class ViewController: UIViewController {
    
    @IBOutlet weak var TableViewMain: PagingTableView!
    private var postDataArray : [PostList] = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableViewMain.pagingDelegate = self
        TableViewMain.dataSource = self
        TableViewMain.delegate = self
    }
    
    func getPostList(pageNumber : Int) {
        print("paginate getPostList: \(pageNumber)")
        let parameters: [String: String] = ["user_nexon_sn": "",
                                            "select_type": "popular",
                                            "tag": "",
                                            "user_type": "",
                                            "pageSize": "20",
                                            "currentPage": "\(pageNumber)"]
        WebServiceManager.shared.callWebService(getPostListURL, parameters: parameters, method: .post) { (response: [PostList]?, error, errorMessage)  in
            self.postDataArray.append(contentsOf: response!)
            self.TableViewMain.reloadData()
            self.TableViewMain.isLoading = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath

        let postData = self.postDataArray[indexPath.row]
        if segue.identifier == "DetailViewSegue"{
            if let destVC = segue.destination as? PostDtailViewController {
                destVC.SNSUserSn = postData.sns_user_sn!
                destVC.postNo = postData.post_no!
            }
            
        }
    }
    
}



extension ViewController : UITableViewDataSource, UITableViewDelegate, PagingTableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewMain.dequeueReusableCell(withIdentifier: "PostListCell", for: indexPath) as! PostListCell
        
        let boardData = self.postDataArray[indexPath.row]
        cell.pNickNameLabel.text = boardData.user_nick
        cell.pClanLabel.text = boardData.clan_name
        if (boardData.user_type == "M") {
            cell.pGenderImg.image = UIImage(named: "icon_man_s.png")
        } else if (boardData.user_type == "F") {
            cell.pGenderImg.image = UIImage(named: "icon_woman_s.png")
        } else {
            cell.pGenderImg.image = nil
        }
        
        
        let url = URL(string: Utils.getProfileImage(boardData.user_img, imgSize: Utils.WebImageSize.small))
        let processor = RoundCornerImageProcessor(cornerRadius: 34)
        cell.pImageView.kf.setImage(with: url, options: [.transition(.fade(0.2)), .processor(processor)])
        
        var likeCnt = boardData.recommend_create_cnt - boardData.recommend_remove_cnt
        var replyCnt = boardData.comment_create_cnt - boardData.comment_remove_cnt
        likeCnt = (likeCnt < 0) ? 0 : likeCnt
        replyCnt = (replyCnt < 0) ? 0 : replyCnt
        
        cell.plikeCntBtn.tag = indexPath.row
        cell.plikeCntBtn.setTitle("\(likeCnt)", for: .normal)
        
        cell.pReplyCntBtn.tag = indexPath.row
        cell.pReplyCntBtn.setTitle("\(replyCnt)", for: .normal)
        
        cell.pGradeImg.image = Utils.getGradeImg(oldLevelNo: boardData.level_no, seasonLevelNo: boardData.season_level_no, seasonflag: boardData.season_level_join_flag, iptTime: boardData.ipt_time)
        
        let dateFomat = DateFormatter()
        dateFomat.dateFormat = "yy'.'MM'.'dd"
        cell.pTimeLabel.text = Utils.convertTimeFormat(inputStr: boardData.ipt_time ?? "", inputFormat: nil, outputFormat: dateFomat)
        cell.pContentLabel.text = boardData.content
        
        
        if (boardData.img_url != "") {
            cell.pPostImageHConstraints.constant = 240
            let url = URL(string: Utils.getPostImage(boardData.img_url, imgSize: Utils.WebImageSize.big))
            cell.pPostImageView.kf.indicatorType = .activity
            cell.pPostImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "post_bg"),
                options: [
                    //                    .processor(processor),
                    //                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }else {
            cell.pPostImageHConstraints.constant = 0
        }
        return cell
    }
    
    
    func paginate(_ tableView: PagingTableView, to page: Int) {
        print("paginate page: \(page)")
        TableViewMain.isLoading = true
        getPostList(pageNumber: page)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tableView didSelectRowAt : \(indexPath)")
        self.performSegue(withIdentifier: "DetailViewSegue", sender: indexPath)
    }
}

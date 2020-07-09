//
//  ViewController.swift
//  TestProject
//
//  Created by Platform Development on 2020/06/17.
//  Copyright © 2020 Platform Development. All rights reserved.
//

import UIKit
import Alamofire

@available(iOS 13.0, *)

struct Config { static let baseURL = "https://saradioapi.nexon.com" }

class ViewController: UIViewController {

    override func viewDidLoad() {
      super.viewDidLoad()
    }
    
    // MARK: - Buttons
    @IBAction func tappedGetButton(_ sender: Any) {
      
    }
    
    @IBAction func tappedPostButton(_ sender: Any) {
      let parameters: [String: Any] = ["user_nexon_sn": "16933964",
                                             "clan_no": "130903003226",
                                             "select_type": "F",
                                             "list_type": ""]
      WebServiceManager.shared.callWebService(getmyPeopleReadURL, parameters: parameters, method: .post) { (response: [User]?, error, errorMessage)  in
        print(response?.count ?? 0)
      }
    }
    
    @IBAction func tappedPost2Button(_ sender: Any) {
      let parameters: [String: Any] = ["user_nexon_sn": "16933964",
                                        "select_type": "popular",
                                        "tag": "",
                                        "user_type": "",
                                        "pageSize": "20",
                                        "currentPage": "1"]
        
      WebServiceManager.shared.callWebService(getPostListURL, parameters: parameters, method: .post) { (response: [Postist]?, error, errorMessage)  in
        print(response?.count ?? 0)
      }
    }
    
}


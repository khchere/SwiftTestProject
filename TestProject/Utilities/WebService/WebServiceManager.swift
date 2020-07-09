//
//  WebServiceManager.swift
//  WebServiceDemo
//
//  Created by Ravi Dhorajiya on 02/05/18.
//  Copyright © 2018 Ravi Dhorajiya. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class WebServiceManager: AuthenticationHeader {
    static let shared = WebServiceManager()
    var alamoFireSessionManager = Alamofire.SessionManager.default


    let newHeaders : HTTPHeaders = [
      "User-Agent": "(apple;)",
      "Content-Type": "application/json; charset=utf-8",
      "Accept": "application/json; charset=utf-8"
    ]
    struct Login: Encodable {
               let user_nexon_sn: String
 
           }
    func callWebService<T: Codable>(_ url: String, parameters: Parameters, method: HTTPMethod, _ encodingType: ParameterEncoding = JSONEncoding.default, completionHandler: @escaping([T]?, _ error: Error?, _ errorMessage: String?) -> Void) {
        
//        AF.request(url, method: .post, parameters: parameters)
//        let parameter: Parameters = ["user_nexon_sn": "",
//                                          "select_type": "popular",
//                                          "tag": "",
//                                          "user_type":"",
//                                          "pageSize": "10",
//                                          "currentPage": "1"]
//        let parameter: [String: [String]] = ["user_nexon_sn": ["16933964"],
//        "select_type": ["popular"],
//        "tag": [""],
//        "user_type":[""],
//        "pageSize": ["10"],
//        "currentPage": ["1"]]
        var param: Parameters = [:]
        param["user_nexon_sn"] = "16933964"
        
        var request = URLRequest(url: URL(string: "http://devsaradio.nexon.com/SAPeople/myRecommendRead.aspx")!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: param, options: [])

//        alamoFireSessionManager.request("http://devsaradio.nexon.com/Auth/AgreeRead.aspx", method: .post, parameters: param, encoder: encoder, headers: newHeaders)
//        alamoFireSessionManager.request("http://devsaradio.nexon.com/SAPeople/myRecommendRead.aspx", method: .post, parameters: param, encoding: JSONEncoding.default, headers: newHeaders)
        alamoFireSessionManager.request("http://devsaradio.nexon.com/SAPeople/myRecommendRead.aspx", method: .post, parameters: param, encoding: URLEncoding.default, headers: newHeaders)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
//                print("response: \(response)")
                switch response.result{
                case .success(let value):
                    print("success: \(value)")
                case .failure(let error):
                    print("error: \(String(describing:error))")
                }
                
        }
//            .responseJSON { response in
//                switch response.result{
//                case .success(_):
//                    let json = response.data
//
//                    do {
//                        let serviceResponse = try JSONDecoder().decode(ServiceResponse<T>.self, from: json!)
//                        print("serviceResponse " ,serviceResponse)
//                        if let status = serviceResponse.sp_rtn {
//                            switch status {
//                            case 0:
//                                completionHandler(serviceResponse.Dataset.response, nil, serviceResponse.error_msg)
//
//                            case -1001301:
//                                completionHandler(nil, nil, serviceResponse.error_msg)
//                            default:
//                                completionHandler(nil, nil, nil)
//                            }
//                        }
//                    } catch let error {
//                        completionHandler(nil, error, nil)
//                    }
//                case .failure(let error):
//                    print("failure " ,error)
//                    completionHandler(nil, error, nil)
//                }
//        }
    }
}

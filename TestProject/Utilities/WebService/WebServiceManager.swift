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


    let newHeaders : HTTPHeaders = [
      "User-Agent": "(Android;)",
      "Content-Type": "application/x-www-form-urlencoded",
      "Accept": "application/json; charset=utf-8"
    ]
    struct Login: Encodable {
               let user_nexon_sn: String
 
           }
    func callWebService<T: Codable>(_ url: String, parameters: [String: String], method: HTTPMethod, _ encoder: ParameterEncoding = JSONEncoding.default, completionHandler: @escaping([T]?, _ error: Error?, _ errorMessage: String?) -> Void) {
        print("callWebService: \(url) ,param: \(parameters)")
        AF.request(url, method: .post, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default ,headers: newHeaders)
        {
            urlRequest in
            urlRequest.timeoutInterval = 5
            urlRequest.allowsConstrainedNetworkAccess = false
        }
            .validate(statusCode: 200..<300)
            .responseJSON { response in
//                print("response: \(response)")
                switch response.result{
                case .success(_):
                    let json = response.data
                    print("response: \(response)")
                    do {
                        let serviceResponse = try JSONDecoder().decode(ServiceResponse<T>.self, from: json!)
                        print("serviceResponse \(serviceResponse)")
                        if let status = serviceResponse.sp_rtn {
                            switch status {
                            case 0:
                                completionHandler(serviceResponse.Dataset, nil, serviceResponse.error_msg)

                            case -1001301:
                                completionHandler(nil, nil, serviceResponse.error_msg)
                            default:
                                completionHandler(nil, nil, nil)
                            }
                        }
                    } catch let error {
                        print("serviceResponse error :  \(error)")
                        completionHandler(nil, error, nil)
                    }
                case .failure(let error):
                    print("failure " ,error)
                    completionHandler(nil, error, nil)
                }
        }
    }
}

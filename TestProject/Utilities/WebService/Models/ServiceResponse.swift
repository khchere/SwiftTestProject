//
//  ServiceResponse.swift
//  WebServiceDemo
//
//  Created by Ravi Dhorajiya on 02/05/18.
//  Copyright © 2018 Ravi Dhorajiya. All rights reserved.
//

import Foundation

struct ServiceResponse<T: Codable>: Codable {

  struct Data<U: Codable>: Codable {
    enum CodingKeys: String, CodingKey {
      case response = "Dataset"
    }
    let response: [U]
  }
  
//  private enum CodingKeys: String, CodingKey {
//    case userToken, status, message, data
//  }
//  let userToken: String?
//  let status: Int?
//  let message: String?
//  let data: Data<T>
//}
  private enum CodingKeys: String, CodingKey {
    case sp_rtn, is_scalar, row_count, error_msg, Dataset
  }
  let row_count: String?
  let is_scalar: String?
  let sp_rtn: Int?
  let error_msg: String?
  let Dataset: Data<T>
}

//func responseKey(_ type: Codable) -> String {
//  switch type {
//  case is User:
//    return "user"
//  case is ProductList:
//    return "product_list"
//  default:
//    return ""
//  }
//}

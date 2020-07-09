//
//  Login.swift
//  WebServiceDemo
//
//  Created by Ravi Dhorajiya on 04/05/18.
//  Copyright © 2018 Ravi Dhorajiya. All rights reserved.
//

import Foundation

class User: Codable {
  private enum CodingKeys: String, CodingKey {
    case id, email, password, gender
    case facebookID = "facebook_id"
    case deviceType = "device_type"
    case deviceToken = "device_token"
    case isDelete = "is_delete"
    case createdDate = "created_date"
    case modifiedDate = "modified_date"
    case guId = "guid"
  }
  let id: Int?
  let facebookID: String?
  let email: String?
  let password: String?
  let gender: Int?
  let deviceType: Int?
  let deviceToken: String?
  let isDelete: Int?
  let createdDate: String?
  let modifiedDate: String?
  let guId: String?
}

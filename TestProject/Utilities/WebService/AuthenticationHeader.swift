//
//  AuthenticationHeader.swift
//  WebServiceDemo
//
//  Created by Ravi Dhorajiya on 02/05/18.
//  Copyright © 2018 Ravi Dhorajiya. All rights reserved.
//

import UIKit

protocol AuthenticationHeader {
  var headers: [String: String] { get }
}

extension AuthenticationHeader {
  var headers: [String: String] {
    return [
      "Access-Key": "nousername",
      "User-Agent": "iOS",
      "Secret-Key": "F7JU3WLONFmUeQZg0nU94VDPTlz1HAuRbXxKscTacWs=",
      "Content-Type": "text/html"
    ]
  }
}

//
//  Utils.swift
//  TestProject
//
//  Created by Platform Development on 2020/07/14.
//  Copyright © 2020 Platform Development. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    enum WebImageSize : String {
        case small = "S"
        case nomal = "M"
        case big = "O"
    }
    
    class func getPostImage(_ strImg: String?, imgSize size: WebImageSize) -> String! {
        if (strImg == "") {
            return ""
        }
        let strYear = ((strImg as NSString?)?.substring(from: 2) as NSString?)?.substring(to: 2)
        let strMMDD = ((strImg as NSString?)?.substring(from: 4) as NSString?)?.substring(to: 4)
        
        var strSizeChar: String?
        
        switch size {
        case WebImageSize.small:
            strSizeChar = WebImageSize.small.rawValue
        case WebImageSize.nomal:
            strSizeChar = WebImageSize.nomal.rawValue
        case WebImageSize.big:
            strSizeChar = WebImageSize.big.rawValue
        }
        
        
        let imgPath = "http://img.s.nx.com/mobile_sns_image/post/\(strSizeChar ?? "")\(strYear ?? "")/\(strMMDD ?? "")/\(strImg ?? "")"
        
        return imgPath
    }
    
    class func getProfileImage(_ strImg: String?, imgSize size: WebImageSize) -> String! {
        
        if (strImg?.count ?? 0) <= 4 {
            return ""
        }
        if (((strImg as NSString?)?.substring(to: 4)) == "http") {
            return strImg
        }
        
        let strYear = ((strImg as NSString?)?.substring(from: 2) as NSString?)?.substring(to: 2)
        let strMMDD = ((strImg as NSString?)?.substring(from: 4) as NSString?)?.substring(to: 4)
        
        var strSizeChar: String?
        switch size {
        case WebImageSize.small:
            strSizeChar = WebImageSize.small.rawValue
        case WebImageSize.nomal:
            strSizeChar = WebImageSize.nomal.rawValue
        case WebImageSize.big:
            strSizeChar = WebImageSize.big.rawValue
        }
        
        let imgPath = "http://img.s.nx.com/mobile_profile_image/\(strSizeChar ?? "")\(strYear ?? "")/\(strMMDD ?? "")/\(strImg ?? "")"
        //    NSLog(@"imgPath : %@", imgPath);
        return imgPath
    }
    
    class func getGradeImg(oldLevelNo: Int, seasonLevelNo: Int, seasonflag seasonFlagYN: String?, iptTime: String?) -> UIImage? {
        var gradeImg = UIImage()
        if seasonFlagYN != nil && (seasonFlagYN == "Y") {
            var image_format = "season20_level_%02d.png"

            if (iptTime?.count ?? 0) > 4 {
                let yearString = (iptTime as NSString?)?.substring(with: NSRange(location: 0, length: 4))
                if self.isNumberic(yearString) && Int(yearString ?? "") ?? 0 < 2020 {
                    image_format = "season19_level_%02d.png"
                }
            }

            if let image = UIImage(named: String(format: image_format, seasonLevelNo)) {
                gradeImg = image
            }
        } else {
            if let image = UIImage(named: String(format: "level_%02d.png", oldLevelNo)) {
                gradeImg = image
            }
        }

        return gradeImg
    }
    
    class func isNumberic(_ strNumber: String?) -> Bool {
        let alphaNums = CharacterSet.decimalDigits
        let inStringSet = CharacterSet(charactersIn: strNumber ?? "")
        return alphaNums.isSuperset(of: inStringSet)
    }

    class func convertTimeFormat(inputStr: String, inputFormat:DateFormatter?, outputFormat:DateFormatter) -> String{
//        print("converTimeFormat input string \(inputStr)")
        if ( inputFormat == nil ) {
           let inputFormat = DateFormatter()
           inputFormat.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SS"
       }
        
        let date = inputFormat?.date(from: inputStr)
        var outputStr = inputStr
        if date != nil {
            outputStr = outputFormat.string(from: date!)
        }
        
        return outputStr
    }
    



}

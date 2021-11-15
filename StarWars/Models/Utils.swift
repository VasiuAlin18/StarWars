//
//  Utils.swift
//  StarWars
//
//  Created by Take Off Labs on 30.10.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum BackendError: Error {
  case urlError(reason: String)
  case objectSerialization(reason: String)
}

class Utils {
    
    class func halfTextColorChange(fullText: String, changeText: String) -> NSMutableAttributedString {
        let string: NSString = fullText as NSString
        
        let range = string.range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSMutableAttributedString.Key.foregroundColor, value: UIColor(named: K.BrandColors.lightOrange) ?? UIColor.orange, range: range)
        
        return attribute
    }
    
    class func checkURL(_ path: String) -> Result<URL, Error> {
        guard var urlComponents = URLComponents(string: path) else {
            return .failure(BackendError.objectSerialization(reason: "Tried to load an invalid URL"))
        }
        urlComponents.scheme = "https"
        guard let url = try? urlComponents.asURL() else {
            return .failure(BackendError.objectSerialization(reason: "Tried to load an invalid URL"))
        }
        
        return .success(url)
    }
    
    class func checkAPIResponse(_ response: AFDataResponse<Any>) -> Result<[String: Any], Error> {
        guard response.error == nil else {
            // got an error in getting the data, need to handle it
            return .failure(response.error!)
        }
      
        // make sure we got JSON and it's a dictionary
        guard let json = response.value as? [String: Any] else {
            return .failure(BackendError.objectSerialization(reason: "Did not get JSON dictionary in response"))
        }
        
        return .success(json)
    }
}

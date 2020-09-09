//
//  NewsSourceModel.swift
//  DailyNews
//
//  Created by Jovial on 9/3/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import Foundation

class NewsSourceModel {
var mStatus : String = ""
var mErrrorMessage : String = ""
var mSource = [SourceModel]()

func loadFromDictionary(_ dict: [String: AnyObject]) {

   if let data = dict["status"] as? String {
      self.mStatus = data
   }
    if let data = dict["message"] as? String {
        self.mErrrorMessage = data
    }
    if let data = dict["sources"] as? Array<Dictionary<String,AnyObject>> {
        for dict in data {
            let modelData = SourceModel.build(dict)
            mSource.append(modelData)
          }
       }
   }
      // MARK: Class Method
        class func build(_ dict: [String: AnyObject]) -> NewsSourceModel{
            let responseDict = NewsSourceModel()
            responseDict.loadFromDictionary(dict)
            return responseDict
        }
    }

 class SourceModel{
    var mId : String = ""
    var mName : String = ""
    var mDescroption : String = ""
    var mCategory : String = ""
    var mLanguage : String = ""
    var mCountry : String = ""
    
    //MARK:- Instance Method
        func loadFromDictionary(_ dict: [String: AnyObject]) {
           if let data = dict["id"] as? String {
              self.mId = data
           }
            if let data = dict["name"] as? String {
               self.mName = data
            }
            if let data = dict["description"] as? String {
               self.mDescroption = data
            }
            if let data = dict["category"] as? String {
               self.mCategory = data
            }
            if let data = dict["language"] as? String {
               self.mLanguage = data
            }
            if let data = dict["country"] as? String {
               self.mCountry = data
            }
   }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> SourceModel{
        let responseDict = SourceModel()
        responseDict.loadFromDictionary(dict)
        return responseDict
    }
}

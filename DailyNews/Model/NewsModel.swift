//
//  NewsModel.swift
//  DailyNews
//
//  Created by Jovial on 9/3/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import Foundation


class NewsModel {
    var mStatus : String = ""
    var mErrrorMessage : String = ""
    var mArticle = [ArticleModel]()
    
    func loadFromDictionary(_ dict: [String: AnyObject]) {
    
       if let data = dict["status"] as? String {
          self.mStatus = data
       }
        if let data = dict["message"] as? String {
            self.mErrrorMessage = data
        }
        if let data = dict["articles"] as? Array<Dictionary<String,AnyObject>> {
            for dict in data {
                let modelData = ArticleModel.build(dict)
                mArticle.append(modelData)
            }
        }
    
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> NewsModel{
        let responseDict = NewsModel()
        responseDict.loadFromDictionary(dict)
        return responseDict
    }
}

class ArticleModel{
    var mSource = SourceDict()
    var mAuthor : String = ""
    var mTitle : String = ""
    var mURL : String = ""
    var mURLToImage : String = ""
    var mPublishTime : String = ""
    
    //MARK:- Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject]) {
         
         if let data = dict["source"] as? Dictionary<String,AnyObject>{
             let modelData = SourceDict.build(data)
             mSource = modelData
         }
        if let data = dict["author"] as? String {
           self.mAuthor = data
        }
        if let data = dict["title"] as? String {
           self.mTitle = data
        }
        if let data = dict["url"] as? String {
           self.mURL = data
        }
        if let data = dict["urlToImage"] as? String {
           self.mURLToImage = data
        }
        if let data = dict["publishedAt"] as? String {
           self.mPublishTime = data
        }
    }
    // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> ArticleModel{
         let responseDict = ArticleModel()
         responseDict.loadFromDictionary(dict)
         return responseDict
     }
}
class SourceDict{
    var sName : String = ""
    
    //MARK:- Instance Method
        func loadFromDictionary(_ dict: [String: AnyObject]) {
            
            if let data = dict["name"] as? String {
               self.sName = data
            }
    }
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> SourceDict{
        let responseDict = SourceDict()
        responseDict.loadFromDictionary(dict)
        return responseDict
    }
}


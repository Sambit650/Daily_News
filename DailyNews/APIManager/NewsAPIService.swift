//
//  NewsAPIService.swift
//  DailyNews
//
//  Created by Jovial on 9/3/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsAPIService {

  // MARK:- Login API
  func callAPIGetNewsDetail(params:String,onSuccess successCallback: ((_ people: NewsModel) -> Void)?,
                            onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
    // Build URL
    let param = params
    
    if param != "Headline"{
      let baseUrl = "https://newsapi.org/v2/everything?q="
      let childURL = "&apiKey=2ad38d35a8d94439a455b6b9cb569974"
      let url = baseUrl + param + childURL

      APICallManager.self.createRequest(
        url, method: .get, headers: nil, parameters: nil,
        onSuccess: {(responseObject: JSON) -> Void in
          // Create dictionary
          if let responseDict = responseObject.dictionaryObject {
            // Create object
            let newsData = NewsModel.build(responseDict as [String : AnyObject])
            // Fire callback
            successCallback?(newsData)
          } else {
            failureCallback?("An error has occured.")
          }
        },
        onFailure: {(errorMessage: String) -> Void in
          failureCallback?(errorMessage)
        }
      )
    }else{
      let url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=2ad38d35a8d94439a455b6b9cb569974"
      APICallManager.self.createRequest(
        url, method: .get, headers: nil, parameters: nil,
        onSuccess: {(responseObject: JSON) -> Void in
          // Create dictionary
          if let responseDict = responseObject.dictionaryObject {
            // Create object
            let newsData = NewsModel.build(responseDict as [String : AnyObject])
            // Fire callback
            successCallback?(newsData)
          } else {
            failureCallback?("An error has occured.")
          }
        },
        onFailure: {(errorMessage: String) -> Void in
          failureCallback?(errorMessage)
        }
      )
    }
  }

  //Get Response and pass data to Controller
  public func callAPIGetNewsDetail(param:String, onSuccess successCallback: ((_ newsResponse: NewsModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
    self.callAPIGetNewsDetail(
      params: param, onSuccess: { (newsResponse) in
        successCallback?(newsResponse)
      },
      onFailure: { (errorMessage) in
        failureCallback?(errorMessage)
      }
    )
  }
}

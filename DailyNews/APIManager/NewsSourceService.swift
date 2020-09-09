//
//  NewsSourceService.swift
//  DailyNews
//
//  Created by Jovial on 9/3/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsSourceService {
    
    // MARK:- Login API
    func callAPIGetNewsSource(onSuccess successCallback: ((_ people: NewsSourceModel) -> Void)?,
        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL

            let url = "https://newsapi.org/v2/sources?apiKey=2ad38d35a8d94439a455b6b9cb569974"
            
            APICallManager.self.createRequest(
                       url, method: .get, headers: nil, parameters: nil,
                       onSuccess: {(responseObject: JSON) -> Void in
                           // Create dictionary
                           if let responseDict = responseObject.dictionaryObject {
                               // Create object
                               let newsData = NewsSourceModel.build(responseDict as [String : AnyObject])
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
    
    //Get Response and pass data to Controller
    public func callAPIGetNewsDetail(param:String, onSuccess successCallback: ((_ newsResponse: NewsSourceModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        self.callAPIGetNewsSource(
             onSuccess: { (newsResponse) in
                successCallback?(newsResponse)
        },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
        }
        )
    }
}

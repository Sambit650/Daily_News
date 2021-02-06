//
//  APIManager.swift
//  DailyNews
//
//  Created by Jovial on 9/3/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import Alamofire
import SwiftyJSON
import Foundation
import MBProgressHUD


enum RequestMethod {
    case get
    case post
}

enum Encoding {
    case URLEncoding
    case JSONEncoding
}

class APICallManager {
    
    static let instance = APICallManager()
    
    //MARK: - MBProgressHUD Loader Methods
    //Start Loader
    static func showGlobalProgressHUDWithTitle(_ title: String) {
        let window = UIApplication.shared.windows[0]
        MBProgressHUD.hide(for: window, animated: true)
        let hud = MBProgressHUD.showAdded(to: window, animated: true)
        hud.mode = .indeterminate
        hud.backgroundView.isUserInteractionEnabled = true
        hud.isUserInteractionEnabled = true
        hud.label.text = title
    }
    
    //Stop Loader
    static func dismissGlobalHUD()->(Void) {
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows[0]
            MBProgressHUD.hide(for: window, animated: true)
        }
    }
    
    // Create request
    class func createRequest(
        _ url: String,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: AnyObject?,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?
    ) {
        
        //Call API with ALamofire
        Alamofire.request(url, method: method, parameters: parameters as? Parameters, encoding: JSONEncoding.default, headers:  headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // print("json :\(json)")
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    // Return
                    callback(error.localizedDescription)
                }
            }
        }
    }
    
}


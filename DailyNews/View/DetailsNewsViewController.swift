//
//  DetailsNewsViewController.swift
//  DailyNews
//
//  Created by Jovial on 9/3/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import UIKit
import WebKit

class DetailsNewsViewController: UIViewController {

    var parseURL : String = ""
    
    @IBOutlet weak var newsWebview: WKWebView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadURL()
    }
    
    func loadURL(){
               self.newsWebview.load(URLRequest(url: URL(string: self.parseURL)!))
       }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

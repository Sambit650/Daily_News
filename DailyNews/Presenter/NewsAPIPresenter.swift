//
//  NewsAPIPresenter.swift
//  DailyNews
//
//  Created by Jovial on 9/3/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import Foundation

protocol NewsViewProtocol: NSObjectProtocol {
    func setNewsDetail(data: NewsModel)
    func showErrorMessage(data: NewsModel)
}

class NewsAPIPresenter {
    private let newsService:NewsAPIService
    weak private var newsView : NewsViewProtocol?
    
    init(newsService:NewsAPIService) {
        self.newsService = newsService
    }
    
    func attachView(view:NewsViewProtocol) {
        newsView = view
    }
    
    func detachView() {
        newsView = nil
    }
    
    func getNewsDetail(newsType : String) {
    APICallManager.showGlobalProgressHUDWithTitle("Loading,please wait...")
        let param = newsType
        newsService.callAPIGetNewsDetail(param: param, onSuccess: { (news) in
            //status = "ok" || "error"
            if news.mStatus == "ok"{
                self.newsView?.setNewsDetail(data: news)
                APICallManager.dismissGlobalHUD()
            }else{
                self.newsView?.showErrorMessage(data: news)
                APICallManager.dismissGlobalHUD()
            }

        }, onFailure: { (errorMessage) in
            APICallManager.dismissGlobalHUD()
        })
    }
   
}

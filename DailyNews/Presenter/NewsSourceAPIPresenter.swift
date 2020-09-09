//
//  NewsSourceAPIPresenter.swift
//  DailyNews
//
//  Created by Jovial on 9/3/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import Foundation

protocol NewsSourceViewProtocol: NSObjectProtocol {
    func setNewsDetail(data: NewsSourceModel)
    func showErrorMessage(data: NewsSourceModel)
}

class NewsSourceAPIPresenter {
    private let newsSourceService : NewsSourceService
    weak private var sourceView : NewsSourceViewProtocol?
    
    init(newsSourceService:NewsSourceService) {
        self.newsSourceService = newsSourceService
    }
    
    func attachView(view:NewsSourceViewProtocol) {
        sourceView = view
    }
    
    func detachView() {
        sourceView = nil
    }
    
    func getNewsSourceDetail() {
    APICallManager.showGlobalProgressHUDWithTitle("Loading,please wait...")
        newsSourceService.callAPIGetNewsSource(onSuccess: { (news) in
            //status = "ok" || "error"
            if news.mStatus == "ok"{
                self.sourceView?.setNewsDetail(data: news)
                APICallManager.dismissGlobalHUD()
            }else{
                self.sourceView?.showErrorMessage(data: news)
                APICallManager.dismissGlobalHUD()
            }

        }, onFailure: { (errorMessage) in
            APICallManager.dismissGlobalHUD()
        })
    }
   
}

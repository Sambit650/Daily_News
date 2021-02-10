//
//  TopHeadlineViewController.swift
//  DailyNews
//
//  Created by Jovial on 9/2/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import UIKit
import SideMenu
import Kingfisher


class TopHeadlineViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate{
    
    //MARK:- Outlets and Properties
    
    @IBOutlet weak var headlineSearchBar: UISearchBar!
    @IBOutlet weak var headlineTableView: UITableView!
    
    let topHeadlinePresenter = NewsAPIPresenter(newsService: NewsAPIService())
    let newsDataModel = NewsModel()
    var searchActive = false
    var searchData = [ArticleModel]()
    
    //MARK:- ViewLifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topHeadlinePresenter.attachView(view: self)
        topHeadlinePresenter.getNewsDetail(newsType: "Headline")
    }
    
    //Dismissing Keyboard
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    //MARK:- Methods
    
    func setUI(){
        headlineTableView.delegate = self
        headlineTableView.dataSource = self
        headlineSearchBar.delegate = self
    }
    
    //MARK:- TableView Delegate and DataSource Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsDataModel.mArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headlineCell = headlineTableView.dequeueReusableCell(withIdentifier: "HeadlineTableViewCell", for: indexPath) as! HeadlineTableViewCell
        headlineCell.newsTitle.text = newsDataModel.mArticle[indexPath.row].mTitle
        headlineCell.newsTime.text = newsDataModel.mArticle[indexPath.row].mPublishTime
        headlineCell.newsImage.kf.setImage(with: URL(string: newsDataModel.mArticle[indexPath.row].mURLToImage))
        return headlineCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let webVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsNewsViewController") as? DetailsNewsViewController
        webVC?.parseURL = newsDataModel.mArticle[indexPath.row].mURL
        webVC?.modalPresentationStyle = .fullScreen
        self.present(webVC!, animated: true)
    }
    
    //searchBar implementation
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //replacing white space with '-'
        let finalText = searchText.replacingOccurrences(of: " ", with: "-")
        topHeadlinePresenter.getNewsDetail(newsType: finalText)
        
        if (searchData.count == 0){
            searchActive = false
            topHeadlinePresenter.getNewsDetail(newsType: "Headline")
        }
        else{
            searchActive = true
        }
        self.headlineTableView.reloadData()
    }
}

//MARKs:- Extensions

extension TopHeadlineViewController : NewsViewProtocol{
    func setNewsDetail(data: NewsModel) {
        //print("Success")
        newsDataModel.mArticle.removeAll()
        newsDataModel.mArticle = data.mArticle
        headlineTableView.reloadData()
    }
    
    func showErrorMessage(data: NewsModel) {
        print("Error")
    }
}

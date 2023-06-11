//
//  ExploreViewController.swift
//  DailyNews
//
//  Created by Jovial on 9/2/20.
//  Copyright © 2020 sambit. All rights reserved.
//

import UIKit
import RSSelectionMenu

class ExploreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

  //MARK:- Outlets and Properties
  @IBOutlet weak var exploreSearchBar: UISearchBar!
  @IBOutlet weak var exploreTableView: UITableView!
  @IBOutlet weak var newsSource: UIButton!

  var sourceDataArray : [String] = [""]
  var sourceSelectedDataArray = [String]()
  let sourceListModel = NewsSourceModel()
  let sourceListPresenter = NewsSourceAPIPresenter(newsSourceService: NewsSourceService())
  let topHeadlinePresenter = NewsAPIPresenter(newsService: NewsAPIService())
  let newsDataModel = NewsModel()
  var searchActive = false
  var searchData = [ArticleModel]()
  var currentSource : String = ""

  //MARK:- View LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    topHeadlinePresenter.attachView(view:self)
    sourceListPresenter.attachView(view: self)
  }

  //Dismissing Keyboard
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }

  //MARK:- Methods
  func setUI(){
    exploreTableView.delegate = self
    exploreTableView.dataSource = self
    exploreSearchBar.delegate = self
    newsSource.layer.cornerRadius = 10
    sourceListPresenter.getNewsSourceDetail()
  }


  //MARK:- TableView Delegate and DataSource Methods

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchActive == true{
      return searchData.count
    }else{
      return newsDataModel.mArticle.count
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let exploreCell = exploreTableView.dequeueReusableCell(withIdentifier: "ExploreTableViewCell", for: indexPath) as! ExploreTableViewCell

    if searchActive == true{
      exploreCell.newsHeader.text = searchData[indexPath.row].mTitle
      exploreCell.newsPublishTime.text = searchData[indexPath.row].mPublishTime
      exploreCell.newsImage.kf.setImage(with: URL(string: searchData[indexPath.row].mURLToImage))
    }else{
      exploreCell.newsHeader.text = newsDataModel.mArticle[indexPath.row].mTitle
      exploreCell.newsPublishTime.text = newsDataModel.mArticle[indexPath.row].mPublishTime
      exploreCell.newsImage.kf.setImage(with: URL(string: newsDataModel.mArticle[indexPath.row].mURLToImage))
    }
    return exploreCell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let webVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsNewsViewController") as? DetailsNewsViewController
    if searchActive == true{
      webVC?.parseURL = searchData[indexPath.row].mURL
    }else{
      webVC?.parseURL = newsDataModel.mArticle[indexPath.row].mURL
    }
    webVC?.modalPresentationStyle = .fullScreen
    self.present(webVC!, animated: true)
  }

  @IBAction func newsSourceButtonPressed(_ sender: Any) {
    showNewsSourceList()
  }

  //Code for Source DropDown
  func showNewsSourceList() {

    let menu = RSSelectionMenu(selectionStyle: .single, dataSource: sourceDataArray) { (cell, name, indexPath) in

      cell.textLabel?.text = name
      cell.tintColor = UIColor.orange
    }
    // provide - selected items and selection delegate

    menu.setSelectedItems(items: sourceSelectedDataArray) { [weak self] (name, index, selected, selectedItems) in
      self?.sourceSelectedDataArray = selectedItems

      for i in self!.sourceListModel.mSource{
        if name == i.mName{
          self?.currentSource = i.mId
        }
      }
      self?.topHeadlinePresenter.getNewsDetail(newsType: self!.currentSource)
      self?.exploreTableView.reloadData()
    }
    // show with search bar

    menu.showSearchBar { [weak self] (searchText) -> ([String]) in

      return self?.sourceDataArray.filter({ $0.lowercased().starts(with: searchText.lowercased()) }) ?? []
    }

    // cell selection style
    menu.cellSelectionStyle = .tickmark
    menu.showEmptyDataLabel()
    menu.show(style: .present, from: self)
  }

  //searchBar implementation
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchActive = false
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchActive = false
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

    searchData = newsDataModel.mArticle.filter({ (text) -> Bool in
      let tmp:NSString = text.mTitle as NSString
      let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
      return range.location != NSNotFound
    })

    if (searchData.count == 0){
      searchActive = false
    }
    else{
      searchActive = true
    }
    self.exploreTableView.reloadData()
  }
}

//MARK:- Extensions

extension ExploreViewController : NewsSourceViewProtocol{
    func setNewsDetail(data: NewsSourceModel) {
        //print("success")
        sourceDataArray.removeAll()
        for source in data.mSource{
            sourceDataArray.append(source.mName)
        }
        sourceListModel.mSource.removeAll()
        sourceListModel.mSource = data.mSource
        topHeadlinePresenter.getNewsDetail(newsType: sourceListModel.mSource[0].mId)
        
    }
    
    func showErrorMessage(data: NewsSourceModel) {
        print("error")
    }
}

extension ExploreViewController : NewsViewProtocol{
    func setNewsDetail(data: NewsModel) {
        // print("sourceSucess")
        newsDataModel.mArticle.removeAll()
        newsDataModel.mArticle = data.mArticle
        exploreTableView.reloadData()
    }
    
    func showErrorMessage(data: NewsModel) {
        print("err")
    }
}


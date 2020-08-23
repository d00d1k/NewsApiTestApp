//
//  ViewController.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 14.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var articles = [Article]()
    
    let searchController = UISearchController(searchResultsController: nil)
    lazy var searchBar = searchController.searchBar
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as? NewsShowCell else {
            return UITableViewCell()
        }
        
        let article = articles[indexPath.row]
        
        cell.updateCell(with: article)
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        articles = []
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchController.searchBar.text! != "" {
            print(searchController.searchBar.text!)
            searchNews(word: searchController.searchBar.text!.lowercased())
        } else {
            articles = []
        }
    }
}

extension SearchViewController {
    
    func searchNews(word: String) {
        
        guard var urlComponents = URLComponents(string: "https://newsapi.org/v2/everything?") else { return }
        
        urlComponents.query = "q=\(word)&apiKey=debbf0c53d1a453d86c219dbde1932c1"
        
        guard let url = urlComponents.url else {
            debugPrint("url is nil")
            return }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if error == nil && data != nil {
                //parse JSON
                let decoder = JSONDecoder()
                
                do {
                    let getNews = try decoder.decode(Articles.self, from: data!)
                    
                    self.articles = getNews.articles
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    debugPrint(" searchNews json err pars")
                }
            }
        }
        
        dataTask.resume()
    }
}

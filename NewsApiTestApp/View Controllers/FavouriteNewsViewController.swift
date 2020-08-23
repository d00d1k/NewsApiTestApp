//
//  FavouriteNewsViewController.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 19.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit

class FavouriteNewsViewController: UIViewController {
    
    let defaults = UserDefaults()
    
    lazy var favouritesList = defaults.value(forKeyPath: "favouriteSourceList") as? [String:String] ?? [:]
    
    var articles = [Article]() {
        didSet { Article.storeNews(articles) }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        articles = Article.retrieveNews() ?? []
        
        for newsSource in Array(favouritesList.keys) {
            getNews(newsSource: newsSource)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
}

extension FavouriteNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsShowCell else {
            return UITableViewCell()
        }
        
        let article = articles[indexPath.row]
        
        cell.updateCell(with: article)
        
        return cell
    }
}

extension FavouriteNewsViewController {
    
    func getNews(newsSource: String) {
        
        guard var urlComponents = URLComponents(string: "https://newsapi.org/v2/top-headlines?") else { return }
        
        urlComponents.query = "sources=\(newsSource)&apiKey=debbf0c53d1a453d86c219dbde1932c1"
        
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
                    
                    self.articles.append(contentsOf: getNews.articles)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch {
                    debugPrint(" getNews json err pars")
                }
            }
        }
        
        dataTask.resume()
    }
}

//
//  FavouriteNewsViewController.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 19.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit
import RealmSwift

class NewsList: Object {
    //@objc dynamic var newsImage = UIImage()
    @objc dynamic var newsTitle = ""
    @objc dynamic var newsDescription = ""
}

class FavouriteNewsViewController: UIViewController {
    
    let defaults = UserDefaults()
    let realm = try! Realm()
    
    lazy var favouritesList = defaults.value(forKeyPath: "favouriteSourceList") as? [String:String] ?? [:]
    lazy var newsList = realm.objects(NewsList.self)
    
    var articles = [Article]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
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
        
        
//
//            print(newsList)
//
//            //return articles.count
//        }
        
//        } else {
//
//            return newsList.count
//        }
        
//        if articles.count != 0 {
//
//            try! realm.write {
//                realm.deleteAll()
//            }
//        }
        
        if newsList.count != 0 {
            return newsList.count
        }
        
        return articles.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsShowCell else {
            return UITableViewCell()
        }
        
        if articles.count != 0 && newsList.count == 0 {
            
            let article = articles[indexPath.row]
            
            cell.updateCell(with: article)
            
        } else if newsList.count != 0 {
            
            let newsItem = newsList[indexPath.row]
            
            cell.newsTitleLabel.text = newsItem.newsTitle
            cell.newsDescriptionLabel.text = newsItem.newsDescription
            
            print(newsList)
        }
        
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
                    //print("json res -> \(getNews)")
                    
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

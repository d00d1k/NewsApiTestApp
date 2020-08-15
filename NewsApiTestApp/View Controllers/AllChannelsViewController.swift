//
//  FirstViewController.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 14.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit

class AllChannelsViewController: UIViewController {
    
    var news: [News] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        news = newsChannelTitleLabelTest()
        getData()
        
        
    }
    
    func newsChannelTitleLabelTest() -> [News] {
        
        var testArr: [News] = []
        
        let title1 = News(title: "Title1", description: "Desc1")
        
        
        
        testArr.append(title1)
        testArr.append(title1)
        testArr.append(title1)
        testArr.append(title1)
        
        return testArr
        
    }
    
    
    
    
}

extension AllChannelsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //let cell = UITableViewCell()
        
        let article = news[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as? NewsChannelCell else {
            return NewsChannelCell() }
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell") as! NewsChannelCell
//
        cell.setTitle(title: article)
        
        return cell
        
    }
}

extension AllChannelsViewController {
    
    func getData() {
        
        let urlString = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=9fd70f07e78145cdae567b8442c6c749"
        let url = URL(string: urlString)
        
        guard url != nil else {
            debugPrint("url is nil")
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                //parse JSON
                let decoder = JSONDecoder()
                
                do {
                    let newsFeed = try decoder.decode(NewsFeed.self, from: data!)
                    print("json res -> \(newsFeed)")
                } catch {
                    debugPrint("jjson err pars")
                }
            }
        }
        
        dataTask.resume()
    }
    
    
}


//
//  FirstViewController.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 14.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit

class AllChannelsViewController: UIViewController {
    
    var sources = [Source]()
    var favouriteSource: [String] = []
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
                
        if defaults.object(forKey: "favouriteSourceList") != nil {
            favouriteSource = defaults.object(forKey: "favouriteSourceList") as? [String] ?? [String]()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.delegate = self
        tableView.dataSource = self
        
        getSource()
    }
}

extension AllChannelsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath) as? NewsChannelCell else {
            return UITableViewCell() }

        cell.newsChannelTitleLabel.text = sources[indexPath.row].name
        cell.newsChannelDescriptionLabel.text = sources[indexPath.row].description
        
        if favouriteSource.contains(cell.newsChannelTitleLabel.text!) {
            cell.favouriteButton.setTitle("+", for: UIControl.State.normal)
        } else {
            cell.favouriteButton.setTitle("-", for: UIControl.State.normal)
        }
        
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteButton.addTarget(self, action: #selector(addToFavorites), for: UIControl.Event.touchUpInside)
        
        return cell
    }
    
    @objc private func addToFavorites(sender: UIButton) {
        
        let cell = self.tableView.cellForRow(at: IndexPath.init(row: sender.tag, section: 0)) as! NewsChannelCell
        
        if favouriteSource.contains(cell.newsChannelTitleLabel.text!) {
            
            if let index = favouriteSource.firstIndex(of: cell.newsChannelTitleLabel.text!) {
                favouriteSource.remove(at: index)
            }
        } else {
            
            favouriteSource.append(cell.newsChannelTitleLabel.text!)
        }
        
        tableView.reloadData()
        defaults.setValue(favouriteSource, forKeyPath: "favouriteSourceList")
        defaults.synchronize()
    }
}

extension AllChannelsViewController {
    
    func getSource(){
        
        let urlString = "https://newsapi.org/v2/sources?apiKey=9fd70f07e78145cdae567b8442c6c749"
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
                    let getSources = try decoder.decode(Sources.self, from: data!)
                    //print("json res -> \(getSources)")
                    
                    self.sources = getSources.sources
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                                        
                } catch {
                    debugPrint("json err pars")
                }
            }
        }
        
        dataTask.resume()
    }
}


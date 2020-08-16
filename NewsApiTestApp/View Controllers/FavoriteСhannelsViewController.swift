//
//  SecondViewController.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 14.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit

class FavoriteСhannelsViewController: UIViewController {
        
    let defaults = UserDefaults()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        defaults.synchronize()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        defaults.synchronize()
        // Do any additional setup after loading the view.
    }

}

extension FavoriteСhannelsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var arrayLength = defaults.value(forKeyPath: "favouriteSourceList") as? [String] ?? [""]
        
        if arrayLength != [""]  {
            arrayLength = defaults.value(forKeyPath: "favouriteSourceList") as! [String]
        } else {
            return 0
        }

        
        return arrayLength.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteNameCell", for: indexPath) as? FavouriteSourceCell else {
        return UITableViewCell() }
        
        let favouritesList = defaults.value(forKeyPath: "favouriteSourceList") as! [String]
        
        cell.favouriteNameCell.text = favouritesList[indexPath.row]
        
        return cell
    }
    
    
}


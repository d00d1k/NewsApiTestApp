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
    lazy var favouritesList = defaults.value(forKeyPath: "favouriteSourceList") as? [String:String] ?? [:]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        print("viewWillAppear > \(favouritesList)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - Table View Extension
extension FavoriteСhannelsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        favouritesList = defaults.value(forKeyPath: "favouriteSourceList") as! [String:String]
        
//        if favouritesList != [:]  {
//            favouritesList = defaults.value(forKeyPath: "favouriteSourceList") as! [String:String]
//        } else {
//            return 0
//        }

        print("arrayLength->\(favouritesList)")
        print(favouritesList.count)
        
        return favouritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteNameCell", for: indexPath) as? FavouriteSourceCell else {
        return UITableViewCell() }
        
        cell.favouriteNameCell.text = Array(favouritesList.values.sorted())[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            if let index = favouritesList.values.firstIndex(of: Array(favouritesList.values)[indexPath.row]){
                favouritesList.remove(at: index)
                
            }
            
            defaults.setValue(favouritesList, forKeyPath: "favouriteSourceList")
            
            print("dict after delete\(favouritesList)")
            
    
            print("favouritesList after delete \(favouritesList)")
            
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
}


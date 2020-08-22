//
//  NewsShowCell.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 19.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit
import RealmSwift

class NewsShowCell: UITableViewCell {
    
    let realm = try! Realm()
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(with headlines: Article) {
        
        let errorURL = URL(string: "https://developers.google.com/maps/documentation/streetview/images/error-image-generic.png")

//        let newsList = NewsList(value: ["newsTitle": headlines.title ?? "No title",
//                                        "newsDescription": headlines.description ?? "No description"])
        let newsList = NewsList()
        
        if headlines.title != "" && headlines.description != "" {
            
            newsList.newsTitle = headlines.title ?? "No title"
            newsList.newsDescription = headlines.description ?? "No description"
        }
        
        newsTitleLabel.text = newsList.newsTitle
        
        if newsList.newsDescription == "" {
            newsDescriptionLabel.text = "No description"
        } else {
            newsDescriptionLabel.text = newsList.newsDescription
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            do {
                let data = try Data(contentsOf: ((headlines.urlToImage ?? errorURL)!))
                let myimage = UIImage(data: data)
                DispatchQueue.main.sync {
                    self.newsImage.image = myimage
                }
            } catch {
                debugPrint("img error")
            }
        }
    }
}

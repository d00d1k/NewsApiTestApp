//
//  NewsShowCell.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 19.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit

class NewsShowCell: UITableViewCell {
    
    
    
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
        
        newsTitleLabel.text = headlines.title
        
        if headlines.description == "" {
            newsDescriptionLabel.text = "No description"
        } else {
            newsDescriptionLabel.text = headlines.description
        }

        DispatchQueue.global(qos: .userInitiated).async {
            
            do {
                let data = try Data(contentsOf: (headlines.urlToImage!))
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

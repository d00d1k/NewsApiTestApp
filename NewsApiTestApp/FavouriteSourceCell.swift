//
//  TableViewCell.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 16.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit

class FavouriteSourceCell: UITableViewCell {
    
    
    @IBOutlet weak var favouriteNameCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}

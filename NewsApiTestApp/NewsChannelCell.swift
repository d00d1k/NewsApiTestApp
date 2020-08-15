//
//  NewsChannelCell.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 14.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import UIKit


class NewsChannelCell: UITableViewCell {

    @IBOutlet weak var newsChannelTitleLabel: UILabel!
    @IBOutlet weak var newsChannelDescriptionLabel: UILabel!

    func setTitle(title: Source) {
        newsChannelDescriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
        newsChannelTitleLabel.text = "Source name"
    }

}









//
//  NewsFeed.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 15.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import Foundation

struct NewsFeed: Codable {
    
    var status: String = ""
    var totalResults: Int = 0
    var articles: [Article]?
}

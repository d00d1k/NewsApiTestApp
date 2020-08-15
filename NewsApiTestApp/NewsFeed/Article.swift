//
//  Article.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 15.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import Foundation

struct Article: Codable {
    
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
}

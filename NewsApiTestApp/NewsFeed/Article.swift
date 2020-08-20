//
//  Article.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 15.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import Foundation

struct Articles: Codable {
    let articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
}

struct Article: Codable {
    
    var source: SourceNews?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: URL?
    var publishedAt: String?
    var content: String?
}

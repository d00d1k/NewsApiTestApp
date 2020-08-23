//
//  Article.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 15.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import Foundation

struct Articles: Codable, Hashable {
    let articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
}

struct Article: Codable, Hashable {
    
    var source: SourceNews?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: URL?
    var publishedAt: String?
    var content: String?
    
    init(source: SourceNews, author: String?, title: String?,description: String?, url: String?, urlToImage: URL?, publishedAt: String?,content: String?) {
        
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        
    }
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("articles")

    static func storeNews(_ articles: [Article]) {
        let oldNews = retrieveNews() ?? []
        guard oldNews != articles else { return }
        let mergedNews = Array(Set(articles + oldNews))
        do {
            let data = try PropertyListEncoder().encode(mergedNews)
            let success = NSKeyedArchiver.archiveRootObject(data, toFile: Article.archiveURL.path)
            print(success ? "Successful save" : "Save Failed")
        } catch {
            print("Save Failed")
        }
    }

    static func retrieveNews() -> [Article]? {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: Article.archiveURL.path) as? Data else { return nil }
        do {
            return try PropertyListDecoder().decode([Article].self, from: data)
        } catch {
            print("Retrieve Failed")
            return nil
        }
    }
}



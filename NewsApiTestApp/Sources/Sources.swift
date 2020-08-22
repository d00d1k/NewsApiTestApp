//
//  Sources.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 15.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import Foundation

struct Sources: Codable {
    
    let sources: [Source]
    
    init(sources: [Source]) {
        self.sources = sources
    }
}

struct Source: Codable, Hashable {
    
    var id: String
    var name: String?
    var description: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    
    init(id: String, name: String?, description: String?, url: String?, category: String?, language: String?, country: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("sources")
    
    static func storeSources(_ sources: [Source]) {
        let oldSources = retrieveSources() ?? []
        guard oldSources != sources else { return }
        let mergedSources = Array(Set(oldSources + sources))
        do {
            let data = try PropertyListEncoder().encode(mergedSources)
            let success = NSKeyedArchiver.archiveRootObject(data, toFile: Source.archiveURL.path)
            print(success ? "Successful save" : "Save Failed")
        } catch {
            print("Save Failed")
        }
    }
    
    static func retrieveSources() -> [Source]? {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: Source.archiveURL.path) as? Data else { return nil }
        do {
            return try PropertyListDecoder().decode([Source].self, from: data)
        } catch {
            print("Retrieve Failed")
            return nil
        }
    }
}

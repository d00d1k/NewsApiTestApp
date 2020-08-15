//
//  SourcesList.swift
//  NewsApiTestApp
//
//  Created by Nikita Kalyuzhnyy on 15.08.2020.
//  Copyright © 2020 Nikita Kalyuzhnyy. All rights reserved.
//

import Foundation

struct SourcesList: Codable {
    
    var status: String = ""
    var sources: [Source]?
    
}

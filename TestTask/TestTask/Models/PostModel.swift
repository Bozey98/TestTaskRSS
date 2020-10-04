//
//  PostModel.swift
//  TestTask
//
//  Created by Денис Мусатов on 04.10.2020.
//

import Foundation

class Post {
    var title: String
    var description: String
    var pubDate: String
    
    var isWatched: Bool
    
    init() {
        self.title = ""
        self.description = ""
        self.pubDate = ""
        
        self.isWatched = false
    }
    
    func removeTags() {
        self.title = self.title.removeHTML()
        self.description = self.description.removeHTML()
        self.pubDate = self.pubDate.removeHTML()
        self.pubDate = String(self.pubDate.dropLast(10))
    }
    
    func watchPost() {
        self.isWatched = true
    }
}

//
//  SourcesModel.swift
//  TestTask
//
//  Created by Денис Мусатов on 23.10.2020.
//

import Foundation

class SourcesModel {
    var sources: [String] {
        didSet {
            NotificationCenter.default.post(Notification(name: Notification.Name.tableChangeValue))
        }
    }
    private(set) var currentSource: String
    
    init() {
        sources = [
            "https://www.finam.ru/net/analysis/conews/rsspoint",
            "https://www.banki.ru/xml/news.rss"
        ]
        currentSource = sources[0]
    }
    
    func changeSource(id: Int) {
        if sources.count > id {
            self.currentSource = sources[id]
        }
        
    }
    
    
}

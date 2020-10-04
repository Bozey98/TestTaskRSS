//
//  RSSParser.swift
//  TestTask
//
//  Created by Денис Мусатов on 03.10.2020.
//

import UIKit

class RSSParser: NSObject, XMLParserDelegate {
    
    var parser: XMLParser!
    
    var posts: [Post] = []
    var tempPost: Post? = nil
    var tempElement: String?
    let urlRSS = "https://www.finam.ru/net/analysis/conews/rsspoint"
    
    override init() {
        super.init()
        guard let url = URL(string: urlRSS ) else { return }
        parser = XMLParser(contentsOf: url)
        parser.delegate = self
        parser.parse()
        print(posts)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        tempElement = elementName
            if elementName == "item" {
                tempPost = Post()
            }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            if let post = tempPost {
                post.removeTags()
                posts.append(post)
            }
            tempPost = nil
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if let post = tempPost {
            if tempElement == "title" {
                tempPost?.title = post.title+string
            } else if tempElement == "description" {
                
                tempPost?.description = post.description+string
            } else if tempElement == "pubDate" {
                tempPost?.pubDate = post.pubDate+string
            }
        }
    }
    
    
    
}


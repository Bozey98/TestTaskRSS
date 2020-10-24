//
//  RSSParser.swift
//  TestTask
//
//  Created by Денис Мусатов on 03.10.2020.
//

import UIKit

class RSSParser: NSObject, XMLParserDelegate {
    
    static let shared = RSSParser()
    
    private var parser: XMLParser!
    
    var siteTitle = ""
    private var titileReady = true
    
    var posts: [Post] = []
    private var tempPost: Post? = nil
    private var tempElement: String?
    private var urlRSS = "https://www.finam.ru/net/analysis/conews/rsspoint"
    
    private override init() {
        super.init()
        initParsing()
        
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Heh")
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
        } else if elementName == "title" {
            titileReady = false
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
        } else if titileReady {
            if tempElement == "title" {
                siteTitle += string
            }
            
        }
    }
    
    func reloadData(with url: String) {
        self.urlRSS = url
        initParsing()
        print(siteTitle)
    }
    
    func updateCurrentPage() {
        initParsing()
    }
    
    func initParsing() {
        
        print(urlRSS)
        posts = []
        siteTitle = ""
        titileReady = true
        guard let url = URL(string: self.urlRSS ) else {
            siteTitle = "Wrong Resource"
            return
        }
        parser = XMLParser(contentsOf: url)
        parser.delegate = self
        parser.parse()
        checkContent()
    }
    
    func checkContent() {
        if posts.isEmpty {
            self.siteTitle = "Ooops, some problems"
        }
    }
    
    
    
}


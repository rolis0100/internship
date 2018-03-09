//
//  FeedParser.swift
//  TestApp
//
//  Created by Роман Бондарев on 07.03.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import Foundation

// Alias to represent the tuple, whitch has the esenssial fields of an articles.
typealias ArticleItem = (title: String, description: String, pubDate: String, media: String, link: String)

class FeedParser: NSObject, XMLParserDelegate {
    
    // Decrale an array of tuples to store the items
    
    private var rssItems: [ArticleItem] = []
    
    // Declare an ennumeration for XML tag that we are interested
    
    enum RssTag: String {
        case item = "item"
        case title = "title"
        case description = "description"
        case pubDate = "pubDate"
        case media = "media:thumbnail"
        case link = "link"
    }
    
    // The currentElement variable ia used as a temporary for variable for storing the currently parsed element. The currentTitle, currentDescription and other variables are used to store the value of an element (e.g. the value within the <title> tags) then the parser(_:foundCharacters:) method is called. Because the value may contain white spase and new line characters, we add a property observer to trim these characters.
    private var currentElemnt = ""
    private var currentTitle: String = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in:
                CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentDescription: String = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentPubDate: String = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentMedia: String = "" {
        didSet {
            currentMedia = currentMedia.trimmingCharacters(in:
                CharacterSet.whitespacesAndNewlines)
        }
    }
    private var currentLink: String = "" {
        didSet {
            currentLink = currentLink.trimmingCharacters(in:
                CharacterSet.whitespacesAndNewlines)
        }
    }
    
    // The parserCompletionHandler variable is a closure to be specified by the caller class. You can think of it as a callback function. When parsing finishes, there are certain actions we should to perform the actions at the end of the parsing.
    private var parserComplitionHandler:(([(title: String, description: String, pubDate: String, media: String, link: String)]) -> Void)?
    
    
    // Create an URLSession object and download task to retrieve the XML content asynchronously. when the download comletes, we initialize the parser object with the XML data, set the delegate to itself, and start the parsing.
    
    func parseFeed(feedUrl: String, complitionHandler:(([(title: String, description: String, pubDate: String, media: String, link: String)]) -> Void)?) -> Void {
        
        self.parserComplitionHandler = complitionHandler
        
        
        let request = URLRequest(url: URL(string: feedUrl)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            
            // Parse XML data
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
            })
        
        task.resume()
    }
    
    func parserDidStartDocument(_ parser: XMLParser) {
        rssItems = []
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElemnt = elementName
        
        if currentElemnt == RssTag.item.rawValue {
            
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
            currentMedia = ""
            currentLink = ""
        }
        if elementName == RssTag.media.rawValue {
            currentMedia = attributeDict["url"]!
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElemnt {
        case RssTag.title.rawValue: currentTitle += string
        case RssTag.description.rawValue: currentDescription += string
        case RssTag.pubDate.rawValue: currentPubDate += string
        case RssTag.media.rawValue: currentMedia += string
        case RssTag.link.rawValue: currentLink += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == RssTag.item.rawValue {
            let rssItem = (title: currentTitle, description: currentDescription, pubDate: currentPubDate, media: currentMedia, link: currentLink)
            
            rssItems += [rssItem]
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserComplitionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}

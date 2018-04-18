//
//  NewsTableViewController.swift
//  TestApp
//
//  Created by Роман Бондарев on 07.03.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    private var rssItems:[ArticleItem]?
    var refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = refresh
downloadData()
        refresh.tintColor = UIColor(red: 157/255, green: 21/255, blue: 27/255, alpha: 0.5)
        refresh.addTarget(self, action: #selector(refreshDowloadData(sender:)), for: .valueChanged)
    }
    // The parseFeed method parse the specified RSS feed. Save rssItems and ask the table view to display them by reloading the table data.
    private func downloadData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(feedUrl: "http://feeds.bbci.co.uk/news/technology/rss.xml", complitionHandler: { (rssItems: [ArticleItem]) -> Void in
            
            self.rssItems = rssItems
            OperationQueue.main.addOperation({ () -> Void in
                
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            })
        })
    }
    
    //Pull to refresh
    @objc func refreshDowloadData(sender: Any) {
        downloadData()
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            return 0
        }
        
        return rssItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell

        // Configure the cell...
        if let item = rssItems?[indexPath.row] {
            cell.TitleLable.text = item.title
            cell.DescLable.text = item.description
            cell.DateLable.text = item.pubDate
            cell.ImgView.downloadImage(url: item.media)
        }

        return cell
    }

   
     //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailViewController
                if let item = rssItems?[indexPath.row] {
                    destinationController.titleLable = item.title
                    destinationController.descLable = item.description
                    destinationController.dateLable = item.pubDate
                    destinationController.ImageLable = item.media
                    destinationController.link = item.link
                }
            }
        }
    }
    

}

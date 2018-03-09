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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // The parseFeed method parse the specified RSS feed. Save rssItems and ask the table view to display them by reloading the table data.
        let feedParser = FeedParser()
        feedParser.parseFeed(feedUrl: "https://feeds.bbci.co.uk/news/technology/rss.xml", complitionHandler: { (rssItems: [ArticleItem]) -> Void in
            
            self.rssItems = rssItems
            OperationQueue.main.addOperation({ () -> Void in
               
                self.tableView.reloadSections(IndexSet(integer: 0), with: .none)
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
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
        }

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

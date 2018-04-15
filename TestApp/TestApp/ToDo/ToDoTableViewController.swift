//
//  ToDoTableViewController.swift
//  TestApp
//
//  Created by Роман Бондарев on 11.04.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    //Fetch result contorller
    var fetchResultController: NSFetchedResultsController<Task>!
    var task: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Remove extra separators from TableView
        tableView.tableFooterView = UIView()

        //Create fetch request with descriptor
        let fetchRequst: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timeCreate", ascending: true)
        fetchRequst.sortDescriptors = [sortDescriptor]
        
        //Getting context
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            //Creating fetch result controller
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequst, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            //Trying to retrieve data
            do {
                try fetchResultController.performFetch()
                task = fetchResultController.fetchedObjects!
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    
    // MARK: - Fetch results controller delegate
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .bottom)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        task = controller.fetchedObjects as! [Task]
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //print("\(task.count)")
        return task.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell

        // Crossed out title
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: task[indexPath.row].title!)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        //task[indexPath.row].status = ""
        if task[indexPath.row].status == "Active" {
            cell.titleLable.text = task[indexPath.row].title
        } else {
            cell.titleLable.attributedText = attributeString
        }
        print(task[indexPath.row].status as Any)
        
        //cell.titleLable.text = task[indexPath.row].title
        cell.dateLable.text = task[indexPath.row].status
    
        

        return cell
        
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.task.remove(at: indexPath.row)
            //Tableview reload 
            tableView.deleteRows(at: [indexPath], with: .fade)
            //Getting context
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                
                let objectToDelete = fetchResultController.object(at: indexPath)
                context.delete(objectToDelete)
                
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            self.task[indexPath.row].status = "Completed"
            
            success(true)
        })
        
        closeAction.image = UIImage(named: "tick")
        closeAction.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [closeAction])
        
      

        
    }

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

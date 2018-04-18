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
    var taskStatus = "Active"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //Remove extra separators from TableView
        self.tableView.tableFooterView = UIView()

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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ToDoTableViewCell
        
        cell.titleLable.text = task[indexPath.row].title
        cell.dateLable.text = task[indexPath.row].timeCreate
    
        // Crossed out title
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: task[indexPath.row].title!)
        attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        //task[indexPath.row].status = ""
        if task[indexPath.row].status == "Active" {
            cell.titleLable.text = task[indexPath.row].title
        } else {
            cell.titleLable.attributedText = attributeString
        }
        
        return cell
    }
 
    // Left swipe - delete cell.
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let todo = self.fetchResultController.object(at: indexPath)
            self.fetchResultController.managedObjectContext.delete(todo)
            do {
                try self.fetchResultController.managedObjectContext.save()
                completion(true)
            }catch {
                print(error.localizedDescription)
                completion(false)
            }
        }
        
        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    //Right swipe - status change.
    @available(iOS 11.0, *)
    override func tableView(_ tableView: UITableView,
                            leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let checkAction = UIContextualAction(style: .normal, title:  "Complete", handler: { (action, view, success) in

            let todo = self.fetchResultController.object(at: indexPath)
            todo.status = "Complete"

            do {
                try self.fetchResultController.managedObjectContext.save()
                success(true)
            } catch {
                print(error.localizedDescription)
                success(false)
            }
        })

        checkAction.image = #imageLiteral(resourceName: "check")
        checkAction.backgroundColor = .green

        return UISwipeActionsConfiguration(actions: [checkAction])
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailToDoViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailToDoViewController
                destinationController.titleLable = self.task[indexPath.row].title!
                destinationController.descLable = self.task[indexPath.row].desc!
                destinationController.dateLable = self.task[indexPath.row].timeCreate!
            }
        }
    }
 

}

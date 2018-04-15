//
//  AddToDoViewController.swift
//  TestApp
//
//  Created by Роман Бондарев on 11.04.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController {
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var titleTextLable: UITextField!
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var descTextLable: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subView.layer.cornerRadius = 10
        addTaskButton.layer.cornerRadius = 20
        
        
        
        //Title TextLable border
        let bordelTitle = CALayer()
        bordelTitle.borderColor = UIColor.darkGray.cgColor
        bordelTitle.frame = CGRect(x: 0, y: 28, width: 268, height: 30)
        bordelTitle.borderWidth = 2
        titleTextLable.layer.addSublayer(bordelTitle)
        titleTextLable.layer.masksToBounds = true
        titleTextLable.leftViewMode = UITextFieldViewMode.always
        
        //Description TextLable border
        let borderDescription = CALayer()
        borderDescription.borderColor = UIColor.darkGray.cgColor
        borderDescription.frame = CGRect(x: 0, y: 28, width: 268, height: 30)
        borderDescription.borderWidth = 2
        descTextLable.layer.addSublayer(borderDescription)
        descTextLable.layer.masksToBounds = true
        descTextLable.leftViewMode = UITextFieldViewMode.always
    }
    
    @IBAction func addButton(_ sender: UIStoryboardSegue) {
        
        if titleTextLable.text == "" && descTextLable.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please, input your task.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okButton)
            present(alertController, animated: true, completion: nil)
        } else {
            
            //Trying get context
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                //Create entity of our task class in the context
                let task = Task(context: context)
                //Set all the properties
                task.id = UUID().uuidString
                task.title = titleTextLable.text
                task.desc = descTextLable.text
                let formater = DateFormatter()
                formater.dateFormat = "HH:mm dd.MM.YYYY"
                task.timeCreate = formater.string(from: Date())
                if task.status == nil {
                    task.status = "Active"
                } else {
                    task.status = "Complet"
                }

                
                //Trying save context
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
            //Back to 
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func addTaskButton(_ sender: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

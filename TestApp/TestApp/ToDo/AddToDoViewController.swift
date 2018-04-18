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
        
    //TextFieldStyle
        titleTextLable.textFieldStyle(textField: titleTextLable)
        descTextLable.textFieldStyle(textField: descTextLable)
        
        //Dismiss keyboard
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func addButton(_ sender: UIStoryboardSegue) {
        
        if titleTextLable.text == "" || descTextLable.text == "" {
            let alertController = UIAlertController(title: "Oops!", message: "Please input all information.", preferredStyle: .alert)
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
}

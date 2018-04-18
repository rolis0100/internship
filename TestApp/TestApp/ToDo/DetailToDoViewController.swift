//
//  DetailToDoViewController.swift
//  TestApp
//
//  Created by Роман Бондарев on 17.04.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import UIKit
import CoreData

class DetailToDoViewController: UIViewController {
    
   
    @IBOutlet weak var detailStackView: UIStackView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailTaskLable: UILabel!
    @IBOutlet weak var titleTaskLable: UILabel!
    @IBOutlet weak var descTaskLable: UILabel!
    @IBOutlet weak var dateTaskLable: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var editStackView: UIStackView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editTaskLable: UILabel!
    @IBOutlet weak var titleTaskTextField: UITextField!
    @IBOutlet weak var descTaskTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var titleLable = ""
    var descLable = ""
    var dateLable = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.layer.cornerRadius = 10
        editView.layer.cornerRadius = 10
        editButton.layer.cornerRadius = 20
        saveButton.layer.cornerRadius = 20
        
        titleTaskLable.text = titleLable
        descTaskLable.text = descLable
        dateTaskLable.text = dateLable
        
        //Title TextLable
        titleTaskTextField.textFieldStyle(textField: titleTaskTextField)
        descTaskTextField.textFieldStyle(textField: descTaskTextField)
        
        //Dismiss keyboard
        self.hideKeyboardWhenTappedAround()
        
        self.editButton.addTarget(self, action: #selector(hiddenView(_:)), for: .touchUpInside)
        self.saveButton.addTarget(self, action: #selector(hiddenView(_:)), for: .touchUpInside)
        
    }

    @IBAction func editButton(_ sender: Any) {
    }
    
    @IBAction func saveButton(_ sender: Any) {
        //Trying get context
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            fetchRequest.predicate = NSPredicate(format: "title = %@", argumentArray: [titleLable])
            fetchRequest.predicate = NSPredicate(format: "desc = %@", argumentArray: [descLable])
            do {
                let results = try context.fetch(fetchRequest) as? [NSManagedObject]
                if results?.count != 0 { // Atleast one was returned
                    
                    // In my case, I only updated the first item in results
                    results![0].setValue(titleTaskTextField.text, forKey: "title")
                    results![0].setValue(descTaskTextField.text, forKey: "desc")
                    try context.save()
                }
            } catch {
                print("Fetch Failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    //Change stackview
    @objc func hiddenView(_ sender: Any) {
        if editStackView.isHidden == false {
            detailStackView.isHidden = false
            editStackView.isHidden = true
            titleTaskLable.text = titleTaskTextField.text
            descTaskLable.text = descTaskTextField.text
        } else {
            if detailStackView.isHidden == false {
                editStackView.isHidden = false
                detailStackView.isHidden = true
                titleTaskTextField.text = titleTaskLable.text
                descTaskTextField.text = descTaskLable.text
            }
        }
    }

}

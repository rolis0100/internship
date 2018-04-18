//
//  Extensions.swift
//  TestApp
//
//  Created by Роман Бондарев on 09.03.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func downloadImage(url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        image = nil
        
        if let imageOfCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageOfCache
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print("error")
                return
            }
            
            DispatchQueue.main.async {
                let imageToCashe = UIImage(data: data!)
                imageCache.setObject(imageToCashe!, forKey: url as AnyObject)
                self.image = imageToCashe
            }
        }
        
        task.resume()
    }
}

extension UITextField {
    func textFieldStyle(textField: UITextField) {
        let border = CALayer()
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: 28, width: 268, height: 30)
        border.borderWidth = 2
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
        textField.leftViewMode = UITextFieldViewMode.always
        textField.tintColor = UIColor.black
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

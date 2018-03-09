//
//  Extensions.swift
//  TestApp
//
//  Created by Роман Бондарев on 09.03.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImage(url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                print("error")
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        
        task.resume()
    }
}

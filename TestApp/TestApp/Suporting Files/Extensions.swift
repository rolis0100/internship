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

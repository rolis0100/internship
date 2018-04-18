//
//  DetailViewController.swift
//  TestApp
//
//  Created by Роман Бондарев on 10.03.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailTitleLable: UILabel!
    @IBOutlet weak var detailImgView: UIImageView!
    @IBOutlet weak var detailDescLable: UILabel!
    @IBOutlet weak var detailDateLable: UILabel!
    
    @IBAction func linkButton(_ sender: Any) {
        if let url = URL(string: link ) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    var titleLable = ""
    var descLable = ""
    var ImageLable = ""
    var dateLable = ""
    var link = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTitleLable.text = titleLable
        detailDescLable.text = descLable
        detailDateLable.text = dateLable
        detailImgView.downloadImage(url: ImageLable)
    }

}

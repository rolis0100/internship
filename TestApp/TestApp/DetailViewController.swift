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

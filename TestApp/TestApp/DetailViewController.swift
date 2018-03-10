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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

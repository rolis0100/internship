//
//  NewsTableViewCell.swift
//  TestApp
//
//  Created by Роман Бондарев on 07.03.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

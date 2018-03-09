//
//  NewsTableViewCell.swift
//  TestApp
//
//  Created by Роман Бондарев on 07.03.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var TitleLable: UILabel!
    @IBOutlet weak var DescLable: UILabel!
    @IBOutlet weak var DateLable: UILabel!
    
    @IBOutlet weak var ImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

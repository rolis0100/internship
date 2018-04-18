//
//  ToDoTableViewCell.swift
//  TestApp
//
//  Created by Роман Бондарев on 11.04.2018.
//  Copyright © 2018 Roman Bondariev. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

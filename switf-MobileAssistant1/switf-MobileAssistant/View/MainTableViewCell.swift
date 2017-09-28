//
//  MainTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/11.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {


    @IBOutlet weak var ColorLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

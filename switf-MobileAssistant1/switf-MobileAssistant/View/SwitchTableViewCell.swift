//
//  SwitchTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/28.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var switchBtn: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

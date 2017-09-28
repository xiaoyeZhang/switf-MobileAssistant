//
//  TxtFieldTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/7.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class TxtFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var titLabel: UILabel!
    @IBOutlet weak var txtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

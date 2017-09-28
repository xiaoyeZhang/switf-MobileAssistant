//
//  MyGroupTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/22.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var GroupName: UILabel!
    @IBOutlet weak var GroupNum: UILabel!
    @IBOutlet weak var GroupState: UILabel!
    @IBOutlet weak var GroupAddress: UILabel!
    @IBOutlet weak var GroupType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

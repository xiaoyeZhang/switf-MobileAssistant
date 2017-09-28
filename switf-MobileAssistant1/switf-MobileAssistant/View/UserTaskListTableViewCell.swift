//
//  UserTaskListTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/22.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class UserTaskListTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var subTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

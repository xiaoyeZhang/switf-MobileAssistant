//
//  Birthday_NewsTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/12.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Birthday_NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelDate: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

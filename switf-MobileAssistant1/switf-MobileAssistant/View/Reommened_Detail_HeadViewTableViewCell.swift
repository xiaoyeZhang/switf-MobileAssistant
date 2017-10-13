//
//  Reommened_Detail_HeadViewTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/11.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Reommened_Detail_HeadViewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var star_1: UIImageView!
    @IBOutlet weak var star_2: UIImageView!
    @IBOutlet weak var star_3: UIImageView!
    @IBOutlet weak var star_4: UIImageView!
    @IBOutlet weak var star_5: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

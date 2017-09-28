//
//  NewsTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/14.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var Icon_State: UIImageView!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

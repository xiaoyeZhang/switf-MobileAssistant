//
//  Small_prece_paperTableViewCell.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/13.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Small_prece_paperTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var isNewLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    let iconImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let size = self.titleLabel.sizeThatFits(CGSize(width: self.titleLabel.frame.size.width, height: CGFloat(MAXFLOAT)))

        iconImage.frame = CGRect(x: size.width + self.titleLabel.frame.origin.x + 3, y: 15, width: 18, height: 18)
        
        iconImage.image = UIImage(named: "icon_has_img")

        self.addSubview(iconImage)

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  small_piece_paperDetailViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/13.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class small_piece_paperDetailViewController: ZXYBaseViewController,UITextViewDelegate {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var user_name_timeLabel: UILabel!
    @IBOutlet weak var reply_Btn: UIButton!
    @IBOutlet weak var ImageBtn: UIButton!
    @IBOutlet weak var reply_contentView: UITextView!
    var entity:small_piece_paperEntity! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "小纸条"
        
        self.titleLabel.text = self.entity.title
        
        self.contentLabel.text = self.entity.content
        
        self.user_name_timeLabel.text = self.entity.create_name! + "     " + (self.entity.create_time?.substring(to: (self.entity.create_time?.index((self.entity.create_time?.startIndex)!, offsetBy: 10))!))!

        
        if (self.entity.img_name?.characters.count)! > 0 {
            
        }else{
            self.ImageBtn.alpha = 0
        }
        
        if self.entity.reply_content == "-1"{
            
            self.reply_contentView.text = ""
        
        }else{
        
            self.reply_contentView.text = self.entity.reply_content
        }
        
        if myModel.type_id == ROLE_CUSTOMER {
            
            if self.entity.reply_content == "-1" {
                self.reply_contentView.text = ""
            }else{
                self.reply_contentView.isUserInteractionEnabled = false
                self.reply_contentView.text = self.entity.reply_content
                self.reply_Btn.alpha = 0

            }
        }else{
            
            if self.entity.reply_content == "-1" {
                
                self.reply_contentView.alpha = 0
                
            }
            
            self.reply_contentView.isUserInteractionEnabled = false
            
            self.reply_Btn.alpha = 0

        }
        
    }
    
    @IBAction func btnTableViewCellBtnClicked(_ sender: UIButton) {
    
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
    
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
            
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

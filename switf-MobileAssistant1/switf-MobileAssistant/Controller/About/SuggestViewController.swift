//
//  SuggestViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/25.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit


class SuggestViewController: ZXYBaseViewController,UITextViewDelegate {

    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var textFileLabel: UILabel!
    @IBOutlet weak var btn0: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    var type_id = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "意见反馈"
        
        self.btn0.isSelected = true
        
    }

    func textViewDidChange(_ textView: UITextView) {
        
        if (textView.text! as NSString).length == 0{
            self.textFileLabel.isHidden = false
        }else{
            self.textFileLabel.isHidden = true
        }
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
         
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    
    @IBAction func doSendFeedback(_ sender: Any) {
        
        if self.TextView.text == ""{
         
            self.ShowAlertCon(title: "警告", message: "请输入反馈内容", cancelTitle: "确定", popC: "0")
            return
        }
        SVProgressHUD.show()
        self.sendData()
    }
    
    func sendData() {

        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"feedback",
             "user_id":myModel.user_id,
             "content":self.TextView.text,
             "type_id":self.type_id,
             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in

            let state = backMsg.object(forKey: "state")
            
            if (state as! NSString).intValue > 0{
                
                self.ShowAlertCon(title: "提示", message: "反馈信息提交成功", cancelTitle: "确定", popC: "1")
            
            }else if (state as! NSString).intValue == 0{
                
                self.ShowAlertCon(title: "提示", message: "反馈信息提交失败", cancelTitle: "确定", popC: "1")
                
            }
         
            SVProgressHUD.dismiss()
            
        }
        

        
    }

    @IBAction func selectBtn(_ sender: UIButton) {
    
        if (sender.tag == 0) {
            self.btn0.isSelected = true
            self.btn1.isSelected = false
            self.btn2.isSelected = false
            self.btn3.isSelected = false
            self.type_id = "0"
        }else if(sender.tag == 1){
            self.btn0.isSelected = false
            self.btn1.isSelected = true
            self.btn2.isSelected = false
            self.btn3.isSelected = false
            self.type_id = "1"
        }else if(sender.tag == 2){
            self.btn0.isSelected = false
            self.btn1.isSelected = false
            self.btn2.isSelected = true
            self.btn3.isSelected = false
            self.type_id = "2";
        }else if(sender.tag == 3){
            self.btn0.isSelected = false
            self.btn1.isSelected = false
            self.btn2.isSelected = false
            self.btn3.isSelected = true
            self.type_id = "3"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

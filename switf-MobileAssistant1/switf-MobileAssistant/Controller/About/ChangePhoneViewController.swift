//
//  ChangePhoneViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/28.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class ChangePhoneViewController: ZXYBaseViewController {

    @IBOutlet weak var numTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var newphoneTxtField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "修改手机号码"
        numTxtField.isUserInteractionEnabled = false
        phoneTxtField.isUserInteractionEnabled = false
        numTxtField.text = myModel.num
        phoneTxtField.text = myModel.tel

    }

    @IBAction func changePhoneBtnClicked(_ sender: UIButton) {

        if newphoneTxtField.text == "" {
            
            self.ShowAlertCon(title: "警告", message: "请输入新手机号", cancelTitle: "确定", popC: "0")
            
            newphoneTxtField.becomeFirstResponder()
            
            return
        }
        if (newphoneTxtField.text! as NSString).length != 11 {
            
            self.ShowAlertCon(title: "警告", message: "手机号格式不对", cancelTitle: "确定", popC: "0")
            
            newphoneTxtField.becomeFirstResponder()
            
            return
        }
        if newphoneTxtField.text == myModel.tel {
            
            self.ShowAlertCon(title: "警告", message: "新输入的手机号码不能跟老手机号一样", cancelTitle: "确定", popC: "0")
            
            newphoneTxtField.becomeFirstResponder()
            
            return
        }
        
        SVProgressHUD.show()

        let process=CommServer()

        let parameters:[String:String] =
            ["method":"whole_province",
             "oicode":"OI_ChangeManagerBillId",
             "user_id":myModel.user_id,
             "ManagerId":numTxtField.text!,
             "NewBillId":newphoneTxtField.text!,
             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state")
            
            if (state as! NSString).intValue == 1{
                
                self.ShowAlertCon(title: "提示", message: "修改成功", cancelTitle: "确定", popC: "1")

                self.loginTask()
                
            }else{
                let content =  backMsg.object(forKey: "reason")
                
                self.ShowAlertCon(title: "提示", message: content as! String, cancelTitle: "确定", popC: "0")
            }
            SVProgressHUD.dismiss()
        }
        
    }
    
    func loginTask() {
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"login",
             "version":APPClientVersion,
             "tel":newphoneTxtField.text!,
             "password":myModel.password,
             ]
        
        process.LoginprocessWithBlock(cmdStr: parameters) { (backMsg) in
            
            if (backMsg.object(forKey: "content") == nil){
                
                
            }else{
                let state: NSNumber = backMsg.object(forKey: "state") as! NSNumber
                
                if state == 2{
                
                }else if state == 3{
                    
                    
                }else{
                   
                }
                
            }
            
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

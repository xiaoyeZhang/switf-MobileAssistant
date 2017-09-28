//
//  ChangePwdViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/26.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class ChangePwdViewController: ZXYBaseViewController,UITextFieldDelegate {

    @IBOutlet weak var numTxtField: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var newPwdTxtField: UITextField!
    @IBOutlet weak var confirmPwdTxtField: UITextField!
    
    var type:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "修改密码"
        
        numTxtField.text = myModel.num
        phoneTxtField.text = myModel.tel
        
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == numTxtField || textField == phoneTxtField {
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func changePwdBtnClicked(_ sender: UIButton) {
    
        if newPwdTxtField.text == "" {

            self.ShowAlertCon(title: "警告", message: "请输入新密码", cancelTitle: "确定", popC: "0")

            newPwdTxtField.becomeFirstResponder()
            
            return
        }
        
        if (newPwdTxtField.text! as NSString).length < 8 {

            self.ShowAlertCon(title: "警告", message: "新密码至少为8位", cancelTitle: "确定", popC: "0")

            newPwdTxtField.becomeFirstResponder()
            
            return
        }
        
        let numregex = "[0-9]"
        
        let daxieregex = "[A-Z]"
        
        let xiaoxieregex = "[a-z]"
        
        let teshuregex = "\\p{Punct}+"

        do {
            let regular1 = try NSRegularExpression(pattern: numregex, options: .dotMatchesLineSeparators)
            
            let results1 = regular1.matches(in: newPwdTxtField.text!, options: .init(rawValue: 0), range: NSMakeRange(0, (newPwdTxtField.text?.characters.count)!))
            
            if results1.count == 0 {
                
                self.ShowAlertCon(title: "警告", message: "密码必须包含数字", cancelTitle: "确定", popC: "0")
                
                newPwdTxtField.becomeFirstResponder()
                
                return
                
            }
        } catch  {
            
        }
        
        do {
            let regular2 = try NSRegularExpression(pattern: daxieregex, options: .dotMatchesLineSeparators)
            
            let results2 = regular2.matches(in: newPwdTxtField.text!, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, (newPwdTxtField.text?.characters.count)!))
            
            if results2.count == 0 {
                
                self.ShowAlertCon(title: "警告", message: "密码必须包含大写字母", cancelTitle: "确定", popC: "0")
                
                newPwdTxtField.becomeFirstResponder()
                
                return
                
            }
            
        } catch  {
            
        }
        
        do {
            let regular3 = try NSRegularExpression(pattern: xiaoxieregex, options: .dotMatchesLineSeparators)
            
            let results3 = regular3.matches(in: newPwdTxtField.text!, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, (newPwdTxtField.text?.characters.count)!))
            if results3.count == 0 {
                
                self.ShowAlertCon(title: "警告", message: "密码必须包含小写字母", cancelTitle: "确定", popC: "0")
                
                newPwdTxtField.becomeFirstResponder()
                
                return
                
            }
        } catch  {
            
        }
        
        do {
            let regular4 = try NSRegularExpression(pattern: teshuregex, options: .dotMatchesLineSeparators)
            
            let results4 = regular4.matches(in: newPwdTxtField.text!, options: .init(rawValue: 0), range: NSMakeRange(0, (newPwdTxtField.text?.characters.count)!))
            
            if results4.count == 0 {
                
                self.ShowAlertCon(title: "警告", message: "密码必须包含特殊符号", cancelTitle: "确定", popC: "0")
                
                newPwdTxtField.becomeFirstResponder()
                
                return
                
            }
        } catch  {
            
        }
        
        if confirmPwdTxtField.text == "" {
            self.ShowAlertCon(title: "警告", message: "请再次确认新密码", cancelTitle: "确定", popC: "0")

            confirmPwdTxtField.becomeFirstResponder()

            return
        }
        
        if confirmPwdTxtField.text != newPwdTxtField.text {
            
            self.ShowAlertCon(title: "警告", message: "新密码和确认密码输入不一致", cancelTitle: "确定", popC: "0")
            
            confirmPwdTxtField.becomeFirstResponder()
            
            return
        }

        SVProgressHUD.show()
        
        self.chageDate()
    }

    func chageDate() {
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"changepassword",
             "num":numTxtField.text!,
             "tel":phoneTxtField.text!,
             "password":newPwdTxtField.text!,
             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
        
            let state = backMsg.object(forKey: "state")
            
            if (state as! NSString).intValue == 1{
            
                let content =  backMsg.object(forKey: "reason")
                if self.type == "3"{
                    
                    let alertController = UIAlertController(title: "提示",message: content as? String,preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .default, handler:{
                        action in
                        
                        let vc = MainViewController()
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        return
                    })
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                }else{
                    self.ShowAlertCon(title: "提示", message: content as! String, cancelTitle: "确定", popC: "1")
                }
                
            }else{
                
            }
            SVProgressHUD.dismiss()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

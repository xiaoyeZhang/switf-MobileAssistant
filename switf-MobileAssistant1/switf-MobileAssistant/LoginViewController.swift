//
//  LoginViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 16/9/20.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController ,UIAlertViewDelegate ,UITabBarControllerDelegate{

    @IBOutlet weak var UserNumText: UITextField!
    @IBOutlet weak var passWordText: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    var myModel:UserEntity!
    
    var okAction = UIAlertAction()
    var alertController = UIAlertController()
    
    var tb = UITabBarController()
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LoginBtn.layer.borderColor = UIColor.white.cgColor

        
        //自定义对象读取
        let myModelData = UserDefaults.standard.data(forKey: "user_message")
    
        //判断UserDefaults中是否已经存在
        if(myModelData != nil){

            myModel = NSKeyedUnarchiver.unarchiveObject(with: myModelData!) as! UserEntity
            
            if myModel.num.characters.count == 0 {
                UserNumText.text = myModel.tel
            }else{
                
                UserNumText.text = myModel.num
            }

            passWordText.text = myModel.password
            
        }else{
        
        }
   }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == passWordText {
            self.view.endEditing(true)
        }
        
        return true
    }
    
    @IBAction func ForgetPwd(_ sender: AnyObject) {
        
        if UserNumText.text?.characters.count == 0 {
            
            UserNumText.becomeFirstResponder()
            
            let alertController = UIAlertController(title: "提示",
                                                    message: "请先输入工号或手机号", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        
        if (UserNumText.text?.characters.count == 11) {
            
            
            alertController = UIAlertController(title: "忘记密码",
                                                message: nil, preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addTextField {
                (textField: UITextField!) -> Void in
                
                textField.placeholder = "请输入你的手机号码"

                
            }
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            okAction = UIAlertAction(title: "提交", style: .default,
                                     handler: {
                                        action in
                                        //也可以用下标的形式获取textField let login = alertController.textFields![0]
//                                        let login = self.alertController.textFields!.first! as UITextField
                                        
            })
            
//            okAction.isEnabled = false

            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
            
            return
        }
        
    }
    
    func accountTextFieldChange(){
        
        if self.alertController.textFields?.first!.text?.characters.count == 11  {
            okAction.isEnabled = true
        }
    }
    
    
    @IBAction func LoginBtn(_ sender: AnyObject) {
        
        
        if UserNumText.text?.characters.count == 0 {
            let alertController = UIAlertController(title: "提醒",message: "你尚未输入用户名，请输入用户名！",preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "关闭", style: .default, handler:{
                action in

            })
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        if passWordText.text?.characters.count == 0 {
            let alertController = UIAlertController(title: "提醒",message: "你尚未输入密码，请输入密码！",preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "关闭", style: .default, handler:{
                action in
            
                self.UserNumText.resignFirstResponder()
                self.passWordText.becomeFirstResponder()
                
            })
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        
        let process=CommServer()
        
        var password = ""
        
        if(myModel != nil){
            if (myModel.password.characters.count > 0) {
                
                password = passWordText.text!
                
            }else{
                
                password = self.sha1(str: passWordText.text!)
                
            }
        }else{
            
            password = self.sha1(str: passWordText.text!)
        
        }
        
        SVProgressHUD.show()

        let parameters:[String:String] =
                            ["method":"login",
                             "version":APPClientVersion,
                             "tel":UserNumText.text!,
                             "password":password,
                             ]

        process.LoginprocessWithBlock(cmdStr: parameters) { (backMsg) in
            
            if (backMsg.object(forKey: "content") == nil){

                let reason = backMsg.object(forKey: "reason") as! String
                
                let alertController = UIAlertController(title: "提示",message: reason,preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .default, handler:{
                    action in
                    
                    if (reason.range(of: "该版本已停用") != nil) || (reason.range(of: "最新版本") != nil){
                        
                        SVProgressHUD.show()
                        
                         self.checkUpdate()
                    }
                    
                })
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                
            }else{
                let state: NSNumber = backMsg.object(forKey: "state") as! NSNumber

                if state == 2{
                    
                    self.getInMainView()
                    
                }else if state == 3{
                    
                    let vc = ChangePwdViewController()
                    
                    vc.type = "3"
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else{
                    let reason = backMsg.object(forKey: "reason") as! String
                    
                    let alertController = UIAlertController(title: "提示",message: reason,preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .default, handler:{
                        action in
                        
                        if (reason.range(of: "该版本已停用") != nil) || (reason.range(of: "最新版本") != nil){
                            
                            SVProgressHUD.show()
                            
                            self.checkUpdate()
                        }
                        
                    })
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                }

            }
        
            SVProgressHUD.dismiss()
        }
        
    }
    
    func checkUpdate() {
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"update_ios_version",
             "version":APPClientVersion,

             ]

        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state: NSNumber = backMsg.object(forKey: "result") as! NSNumber
            
            if state == 2{
                
                let info = backMsg.object(forKey: "info") as! [String:String]
                
                let alertController = UIAlertController(title: "更新提示",message: info["content"],preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .default, handler:{
                    action in
                    let url = NSURL(string: info["url"]!)
                    UIApplication.shared.openURL(url! as URL)
                    
                })
                let otherAction = UIAlertAction(title: "取消", style: .cancel, handler:{
                    action in
                    
                    
                })
                alertController.addAction(cancelAction)
                alertController.addAction(otherAction)
                self.present(alertController, animated: true, completion: nil)
            }else if state == 3{ //强制更新
                
                let info = backMsg.object(forKey: "info") as! [String:String]
                
                let alertController = UIAlertController(title: "更新提示",message: info["content"],preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .default, handler:{
                    action in
                    let url = NSURL(string: info["url"]!)
                    UIApplication.shared.openURL(url! as URL)
                    
                })
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
            }
            SVProgressHUD.dismiss()
        }
        
    }
    
    func getInMainView () {
        
        let MainVc = MainViewController()
        let CoustomerVc = CoustomerViewController()
        let AboutVc = AboutViewController()
        let News = NewsViewController()
        
        MainVc.tabBarItem.title = "主页"
        CoustomerVc.tabBarItem.title = "客户"
        News.tabBarItem.title = "公告"
        AboutVc.tabBarItem.title = "我的"
        
        MainVc.tabBarItem.image = UIImage(named: "tab_hp_press")
        CoustomerVc.tabBarItem.image = UIImage(named: "tab_contact_press")
        News.tabBarItem.image = UIImage(named: "tab_push_press")
        AboutVc.tabBarItem.image = UIImage(named: "tab_about_press")
        
        MainVc.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        CoustomerVc.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        News.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        AboutVc.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        tb = UITabBarController()
        tb.delegate = self
        tb.tabBar.backgroundColor = UIColor.white
        tb.viewControllers = [MainVc,CoustomerVc,News,AboutVc]
        tb.navigationItem.title = "主页"
        

//        [self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColorwhiteColor],NSFontAttributeName:[UIFontboldSystemFontOfSize:17]};
            
        tb.navigationItem.hidesBackButton = true
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        self.navigationController?.pushViewController(tb, animated: true)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let index = tabBarController.selectedIndex
        
//        tb.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        if index == 0 {
            
            tb.navigationItem.title = "主页"
            
        }else if index == 1{
            
            tb.navigationItem.hidesBackButton = true
            
            tb.navigationItem.title = "客户"
            
        }else if index == 2{
            
            tb.navigationItem.hidesBackButton = true
            
            tb.navigationItem.title = "公告"
            
        }else if index == 3{
            
            tb.navigationItem.hidesBackButton = true
            
            tb.navigationItem.title = "我的"
            
        }else{
            
            
        }
        
    }
    
    func sha1(str:String) -> String {

        let cstr = str.data(using: String.Encoding.utf8)
        
        var data = [UInt8](repeatElement(0, count: Int(CC_SHA1_DIGEST_LENGTH)))
        
        let newData = NSData(data: cstr!)
        
        CC_SHA1(newData.bytes, CC_LONG((cstr?.count)!), &data)
    
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        
        for byte in data{
            
            output.appendFormat("%02x", byte)
        }
        
        return output as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
}

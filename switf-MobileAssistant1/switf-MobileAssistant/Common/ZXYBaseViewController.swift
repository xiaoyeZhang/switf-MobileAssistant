//
//  ZXYBaseViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/7.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class ZXYBaseViewController: UIViewController{
    
    var backBtn = UIButton()
    
    let userDefaults = UserDefaults()
    var myModel:UserEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //自定义对象读取
        let myModelData = userDefaults.data(forKey: "user_message")
        myModel = NSKeyedUnarchiver.unarchiveObject(with: myModelData!) as! UserEntity
        
        backBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 44)
        
        backBtn.setImage(UIImage(named: "common_back"), for: UIControlState.normal)
        
        backBtn.addTarget(self, action: #selector(backAction), for: UIControlEvents.touchUpInside)
        
        // 自定义导航栏的UIBarButtonItem类型的按钮
        let leftBarButon = UIBarButtonItem(customView: backBtn)
        
        // 重要方法，用来调整自定义返回view距离左边的距离
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -16
        
        // 返回按钮设置成功

        self.navigationItem.leftBarButtonItems = [barButtonItem , leftBarButon]
        
    }

    func backAction() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func setNaviRightBtnWithTitle(title :String) -> UIButton{
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 44))
        
        rightBtn.setTitle(title, for: UIControlState.normal)
        
        let rightBarButon = UIBarButtonItem(customView: rightBtn)
        
        // 重要方法，用来调整自定义返回view距离左边的距离
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = -16
        
        self.navigationItem.rightBarButtonItems = [barButtonItem , rightBarButon]
        
        return rightBtn
        
    }
    
    func ShowAlertCon(title:String,message:String,cancelTitle:String,popC:String) {
        
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler:{
            action in
            if popC == "1"{
                self.navigationController?.popViewController(animated: true)
            }
            
        })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

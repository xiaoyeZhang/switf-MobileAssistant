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

    var isDone = true

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
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: BUSINESS_LIST_REFRESH_NOTIFY), object: nil)
                
            }
            
        })
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func heightForString(value:String,fontSize:Float,width:Float) -> Float {
        
        let detailTextView:UITextView = UITextView.init(frame: CGRect(x: 0, y: 0, width: Int(width), height: 0))
        
        detailTextView.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        
        detailTextView.text = value
        
        let deSize:CGSize = detailTextView.sizeThatFits(CGSize(width: CGFloat(width), height: CGFloat.greatestFiniteMagnitude))
        
        return Float(deSize.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        // Do something with your image.
                        DispatchQueue.main.async() { () -> Void in
                            self.image = image
                        }
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
            
            }.resume()
        
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

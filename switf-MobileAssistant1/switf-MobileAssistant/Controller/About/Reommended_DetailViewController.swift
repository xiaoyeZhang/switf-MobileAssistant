//
//  Reommended_DetailViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/11.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit
import MessageUI

class Reommended_DetailViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate {
    
    @available(iOS 4.0, *)
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
        
        switch result.rawValue
            
        {
        case MessageComposeResult.sent.rawValue:
            print("短信已发送")
        case MessageComposeResult.cancelled.rawValue:
            print("短信取消发送")
        case MessageComposeResult.failed.rawValue:
            print("短信发送失败")
        default:
            break
        }

    }


    @IBOutlet weak var tableView: UITableView!
    
    var arrayCutomer:NSMutableArray = []
    var cell1:Reommened_Detail_HeadViewTableViewCell! = nil
    var cell2:Reommened_Detail_FoodViewTableViewCell! = nil
    
    var APP_Name = ""
    var APP_ID = ""
    var cellHeight:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = APP_Name + "详情"
        
        let cellNib1 = UINib(nibName: "Reommened_Detail_HeadViewTableViewCell", bundle: nil)
        
        tableView .register(cellNib1, forCellReuseIdentifier: "Reommened_Detail_HeadViewTableViewCell")
        
        let cellNib2 = UINib(nibName: "Reommened_Detail_FoodViewTableViewCell", bundle: nil)
        
        tableView .register(cellNib2, forCellReuseIdentifier: "Reommened_Detail_FoodViewTableViewCell")
        
        self.getData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var num = 0
        
        if self.arrayCutomer.count > 0 {
            num = 2
        }else{
            num = 0
        }
        
        return num
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        if indexPath.row == 0{
            
            return 115
            
        }else{
  
            return CGFloat(cellHeight) + 50
        }
        
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let entity:Recommended_DetailEntity =  arrayCutomer.object(at: 0) as! Recommended_DetailEntity
        
        if indexPath.row == 0{
            
            cell1 = tableView.dequeueReusableCell(withIdentifier: "Reommened_Detail_HeadViewTableViewCell", for: indexPath) as! Reommened_Detail_HeadViewTableViewCell
       
            
            cell1.nameLabel.text = entity.name;
            
            cell1.countLabel.text = "(" + entity.count! + ")"
            
            let urlString = entity.icon
            if let url = URL(string: urlString!) {
                cell1.icon.downloadedFrom(url: url)
            }
            
            self.setStarNum(num: entity.level!)
            
            return cell1
            
        }else {
            
            cell2 = tableView.dequeueReusableCell(withIdentifier: "Reommened_Detail_FoodViewTableViewCell", for: indexPath) as! Reommened_Detail_FoodViewTableViewCell
        

            cellHeight = self.heightForString(value: entity.content!, fontSize: 16, width: Float(cell2.messageLabel.frame.size.width))
            
            cell2.messageLabel.text = entity.content
            
            return cell2
            
        }

    
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//    
//    }
    
    
    func getData()  {
        
        SVProgressHUD.show()
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"get_app_detail",
             "app_id":APP_ID,
             ]

        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            
            let state:NSNumber = backMsg.object(forKey: "state") as! NSNumber
            
            if state == 1{
                
                let attributes:NSDictionary = backMsg.object(forKey: "content") as! NSDictionary
                
                let entity = Recommended_DetailEntity()
                
                entity.initWithAttributes(backMsg: attributes)
                
                self.arrayCutomer.add(entity)

            }else{
                
            }
            
            self.tableView.reloadData()
            
            SVProgressHUD.dismiss()
        }
        
    }
    
    func setStarNum(num:String) {
        

        if num == "1"{
            cell1.star_1.image = UIImage(named: "star_1")
        }else if num == "2"{
            cell1.star_1.image = UIImage(named: "star_1")
            cell1.star_2.image = UIImage(named: "star_1")
        }else if num == "3"{
            cell1.star_1.image = UIImage(named: "star_1")
            cell1.star_2.image = UIImage(named: "star_1")
            cell1.star_3.image = UIImage(named: "star_1")
        }else if num == "4"{
            cell1.star_1.image = UIImage(named: "star_1")
            cell1.star_2.image = UIImage(named: "star_1")
            cell1.star_3.image = UIImage(named: "star_1")
            cell1.star_4.image = UIImage(named: "star_1")
        }else if num == "5"{
            cell1.star_1.image = UIImage(named: "star_1")
            cell1.star_2.image = UIImage(named: "star_1")
            cell1.star_3.image = UIImage(named: "star_1")
            cell1.star_4.image = UIImage(named: "star_1")
            cell1.star_5.image = UIImage(named: "star_1")
            
        }
        
    }
    
    @IBAction func ClickBtn(_ sender: UIButton) {
    
        let process=CommServer()
        
        let parameters:[String:String] = ["method":"share_app",
                                          "app_id":APP_ID]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            if state == 1 {
                
                
                if MFMessageComposeViewController.canSendText()
                {
                    let messageController = MFMessageComposeViewController()
                    
                    let dic:NSDictionary = backMsg.object(forKey: "content") as! NSDictionary
                    
                    //设置短信内容
                    messageController.body = dic["sms_content"] as? String
                    
//                    if self.tel.length != 0 {
//
//                        messageController.recipients = [self.tel]
//
//                    }
                    //设置代理
                    messageController.messageComposeDelegate = self
                    //打开界面
                    self.present(messageController, animated: true, completion: { () -> Void in
                        
                    })
                }
                else
                {
                    print("本设备不能发送短信")
                }
                
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

class Recommended_DetailEntity: NSObject {
    var icon:String?
    var app_id:String?
    var name:String?
    var level:String?
    var count:String?
    var content:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.name = backMsg.object(forKey: "name") as? String
        self.icon = backMsg.object(forKey: "icon") as? String
        self.app_id = backMsg.object(forKey: "app_id") as? String
        self.level = backMsg.object(forKey: "level") as? String
        self.count = backMsg.object(forKey: "count") as? String
        self.content = backMsg.object(forKey: "content") as? String
    }

}

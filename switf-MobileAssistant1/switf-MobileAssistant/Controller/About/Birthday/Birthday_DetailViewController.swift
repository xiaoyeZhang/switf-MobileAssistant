//
//  Birthday_DetailViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/12.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Birthday_DetailViewController: ZXYBaseViewController {


    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLable: UILabel!
    @IBOutlet weak var distanceLable: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var DayLable: UILabel!
    @IBOutlet weak var calendarLable: UILabel!
    @IBOutlet weak var lunarLable: UILabel!
    @IBOutlet weak var zodiacLabel: UILabel!
    @IBOutlet weak var constellationLabel: UILabel!
    @IBOutlet weak var ch_zodiacLabel: UILabel!
    @IBOutlet weak var ch_Label: UILabel!
    @IBOutlet weak var timerTextFile: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewLabel: UILabel!
    
    let entity = Birthday_DetailEntiy()
    
    var birthday_id = ""
    var hourStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let addBtn = self.setNaviRightBtnWithTitle(title: "发送")
        
        addBtn.addTarget(self, action: #selector(sumBitCickBtn), for: UIControlEvents.touchUpInside)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: BUSINESS_LIST_REFRESH_NOTIFY), object: nil)
        
        self.timerTextFile.isUserInteractionEnabled = false
    }
    
    func sumBitCickBtn()  {
        
    }
    
    func getData()  {
    
        SVProgressHUD.show()
        
        let process=CommServer()

        let parameters:[String:String] = ["method":"get_birthday_detail",
                                          "birthday_id":birthday_id]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            if state == 1 {
                
                let attributes:NSDictionary = backMsg.object(forKey: "content") as! NSDictionary
                
                self.entity.initWithAttributes(backMsg: attributes )
                
            }
            
            
        }
        
    }
    
    func reloadView() {
    
        self.nameLabel.text = entity.client_name
        self.positionLable.text = "(" + entity.company_name! + " - " + entity.client_job! + ")"

        self.DayLable.text = entity.date! + "天"
        
        let str:NSMutableAttributedString = NSMutableAttributedString(string: "\(entity.age!)\n\(entity.birthday_date!)")
        
        str.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red:239/255.0, green: 120/255.0, blue: 122/255.0, alpha: 1), range: NSRange.init(location: 0, length:str.length - (entity.birthday_date?.characters.count)!))

        self.birthdayLabel.attributedText = str
        
        self.calendarLable.text = entity.birthday_date_all
        
        self.lunarLable.text = entity.lunar
        self.zodiacLabel.text = entity.ch_zodiac
        self.constellationLabel.text = entity.zodiac
        
        self.timerTextFile.text = (entity.send_time! as NSString).substring(with: NSMakeRange(0, 16))
        
        if (entity.send_time?.characters.count)! > 0 {
            hourStr = (entity.send_time! as NSString).substring(with: NSMakeRange(11, 2)) + ":00"
        }else{
            hourStr = "10:00"
        }

        if (entity.content?.characters.count)! > 0 {
            
            self.textViewLabel.isHidden = true
            self.textView.text = entity.content!
        }

    }
    
    //MARK:定时发送提醒
    @IBAction func addTimeClick(_ sender: UIButton) {
    
    }
    
    //MARK:保存
    @IBAction func saveClick(_ sender: UIButton) {
    
    }
    
    //MARK:取消
    @IBAction func cancelClick(_ sender: UIButton) {
    
    }
    
    //MARK:  短信查询
    @IBAction func queryClick(_ sender: UIButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//MARK: 实体类
class Birthday_DetailEntiy: NSObject {

    var birthday_id:String?
    var company_num:String?
    var company_name:String?
    
    var client_name:String?
    var client_job:String?
    var client_tel:String?
    
    var user_num:String?
    var date:String?
    var ch_zodiac:String?
    var zodiac:String?
    var lunar:String?
    var state:String?
    
    var sms_id:String?
    var content:String?
    var birthday_date:String?
    var age:String?
    var birthday_date_all:String?
    var send_time:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.birthday_id = backMsg.object(forKey: "birthday_id") as? String
        self.company_num = backMsg.object(forKey: "company_num") as? String
        self.company_name = backMsg.object(forKey: "company_name") as? String
        
        self.client_name = backMsg.object(forKey: "client_name") as? String
        self.client_job = backMsg.object(forKey: "client_job") as? String
        self.client_tel = backMsg.object(forKey: "client_tel") as? String
        
        self.user_num = backMsg.object(forKey: "user_num") as? String
        self.date = backMsg.object(forKey: "date") as? String
        self.ch_zodiac = backMsg.object(forKey: "ch_zodiac") as? String
        self.zodiac = backMsg.object(forKey: "zodiac") as? String
        self.lunar = backMsg.object(forKey: "lunar") as? String
        self.state = backMsg.object(forKey: "state") as? String
        
        self.sms_id = backMsg.object(forKey: "sms_id") as? String
        self.content = backMsg.object(forKey: "content") as? String
        self.birthday_date = backMsg.object(forKey: "birthday_date") as? String
        self.age = backMsg.object(forKey: "age") as? String
        self.birthday_date_all = backMsg.object(forKey: "birthday_date_all") as? String
        self.send_time = backMsg.object(forKey: "send_time") as? String
    }
}

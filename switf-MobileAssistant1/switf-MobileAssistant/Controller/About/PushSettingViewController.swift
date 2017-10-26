//
//  PushSettingViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/25.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class PushSettingViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArr:NSArray!
    var swith_selectArr:NSMutableArray = []
    
    var dic:[String:Any] = [:]
    
    var cell2:SwitchTableViewCell! = nil
    
    var pushStateDic:[String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "推送时间设置"
        
        let RightBtn:UIButton = self.setNaviRightBtnWithTitle(title: "提交")
        
        RightBtn.addTarget(self, action: #selector(submitBtnClicked), for: UIControlEvents.touchUpInside)
        
        let cellNib1 = UINib(nibName: "PushSettingTableViewCell", bundle: nil)
        
        tableView .register(cellNib1, forCellReuseIdentifier: "PushSettingTableViewCell")
        
        let cellNib2 = UINib(nibName: "SwitchTableViewCell", bundle: nil)
        
        tableView .register(cellNib2, forCellReuseIdentifier: "SwitchTableViewCell")
        
        dataArr = [["title":"周日","select":false],
                    ["title":"周一","select":false],
                    ["title":"周二","select":false],
                    ["title":"周三","select":false],
                    ["title":"周四","select":false],
                    ["title":"周五","select":false],
                    ["title":"周六","select":false],
                    ["title":"短信推送","Switch_select":false],
                    ["title":"欠费催缴","Switch_select":false],
                    ["title":"客户生日提醒","Switch_select":false],
                    ["title":"长期未拜访","Switch_select":false]]
        
        tableView.tableFooterView = UIView()
        
        self.getSettingFromServer()
    }

    func submitBtnClicked()  {
                
        if !isDone{
            return
        }
        
        isDone = false
        
        let selectedMuArr:NSMutableArray = []
        
        for i in 0..<dataArr.count{
            
            let dic:[String:Any] =  dataArr!.object(at: i) as AnyObject as! [String : Any]
            
            if dic.keys.contains("select"){
                
                if self.dic.keys.contains(String(i)) {
                    selectedMuArr.add(String(i))
                }
            }
        }
        let push_date = selectedMuArr.componentsJoined(by: ",")

        var num = 0
        
        if swith_selectArr.count != 0 {
            
            num = swith_selectArr[0] as! Int
            
            for i in 1..<swith_selectArr.count{
                
                let Inum:Int = swith_selectArr[i] as! Int
                
                num = num|Inum
                
            }
            
        }
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"config_push",
             "user_id":myModel.user_id,
             "push_date":push_date,
             "push_disable":"0",
             "push_endtime":"17:00:00",
             "push_flag":String(num),
             "push_sms":"0",
             "push_starttime":"09:00:00",
             ]
        SVProgressHUD.show()
 
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state:NSNumber = backMsg.object(forKey: "state") as!NSNumber
            
            if state == 1{
                
                self.navigationController?.popViewController(animated: true)
                
            }
            
            self.isDone = true
            
            SVProgressHUD.dismiss()
        }

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArr.count
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let dic:[String:Any] =  dataArr!.object(at: indexPath.row) as AnyObject as! [String : Any]
        
        if dic.keys.contains("select") {
            
            let cell1:PushSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PushSettingTableViewCell", for: indexPath) as! PushSettingTableViewCell

            cell1.titleLbl.text = dic["title"] as? String
            if self.dic.keys.contains(String(indexPath.row)) {
                cell1.checkBoxBtn.isSelected = true
            }else{
                cell1.checkBoxBtn.isSelected = false
            }
            
            return cell1
        
        }else{

            cell2 = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
            
            cell2.switchBtn.tag = indexPath.row
            
            cell2.switchBtn.addTarget(self, action: #selector(switchChanged), for: UIControlEvents.touchUpInside)
            
            cell2.titleLabel.text = dic["title"] as? String
            
            if self.dic.keys.contains(String(indexPath.row)) {
                cell2.switchBtn.isOn = true
            }else{
                cell2.switchBtn.isOn = false
            }
            return cell2

        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dic:[String:Any] =  dataArr!.object(at: indexPath.row) as AnyObject as! [String : Any]
        
        if self.dic.keys.contains(String(indexPath.row)) {
            self.dic.removeValue(forKey: String(indexPath.row))
        }else{
            self.dic.updateValue(true, forKey: String(indexPath.row))
        }
        
        if dic.keys.contains("Switch_select") {
            
            cell2.switchBtn.tag = indexPath.row
            
            self.switchChanged(sender: cell2.switchBtn)
            
        }else{
        
        }

        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }
    
    func getSettingFromServer()  {
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"push_state",
             "user_id":myModel.user_id,
             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state")
            
            if (state as! NSString).intValue == 1{
            
                let contentDic:[String:String] = backMsg.object(forKey: "content") as! [String:String]
                print("ddfsdfsdf: \(String(describing: backMsg.object(forKey: "content")))")
                
                let enableDate:Array = (contentDic["push_date"]?.components(separatedBy: ","))!
                for str in enableDate{
                    
                    self.dic.updateValue(true, forKey: str)
                    
                }
                
                self.pushStateDic.updateValue(contentDic["push_date"]! , forKey: "push_date")
                self.pushStateDic.updateValue(contentDic["push_starttime"]! , forKey: "push_starttime")
                self.pushStateDic.updateValue(contentDic["push_endtime"]!  , forKey: "push_endtime")
                self.pushStateDic.updateValue(contentDic["push_flag"]!  , forKey: "push_flag")
                
            
                self.OrChangeAnd(push_flag: self.pushStateDic["push_flag"]!)
                
                self.tableView.reloadData()

            }
        }
    }
    
    func switchChanged(sender:UISwitch) {
        
        switch sender.tag {
        case 7:
            if (sender.isOn) {
                swith_selectArr.add(1)
            }else{
                swith_selectArr.remove(1)
            }
            break
        case 8:
            if (sender.isOn) {
                swith_selectArr.add(2)
            }else{
                swith_selectArr.remove(2)
            }
            break
        case 9:
            if (sender.isOn) {
                swith_selectArr.add(4)
            }else{
                swith_selectArr.remove(4)
            }
            break
        case 10:
            if (sender.isOn) {
                swith_selectArr.add(8)
            }else{
                swith_selectArr.remove(8)
            }
            break
        default:
            break
        }
        
    }
    
    func OrChangeAnd(push_flag:String) {
        
        let num:NSInteger = Int(push_flag)!
        
        if num&1 == 1{
            self.dic.updateValue(true, forKey: "7")
            swith_selectArr.add(1)
        }
        if num&2 == 2{
            self.dic.updateValue(true, forKey: "8")
            swith_selectArr.add(2)
        }
        if num&4 == 4{
            self.dic.updateValue(true, forKey: "9")
            swith_selectArr.add(4)
        }
        if num&8 == 8{
            self.dic.updateValue(true, forKey: "10")
            swith_selectArr.add(8)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

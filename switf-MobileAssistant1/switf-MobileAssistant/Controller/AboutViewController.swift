//
//  AboutViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/16.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let userDefaults = UserDefaults()
    
    var myModel:UserEntity!
    
    var sectionArray:NSMutableArray = []

    var selectedDic:[String:Int] = [:]
    
    var visitArray:NSMutableArray = []
    
    var reloadArray : [IndexPath]!
    
    var this_month_visitArr:NSMutableArray = []
    
    var this_month_unvisitArr:NSMutableArray = []
    
    var unfinishedDict:NSDictionary = [:]
    
    var expandDic:[String:Bool] = [:]
    
    var finishDic:[String:String] = [:]
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的"
        
        NotificationCenter.default.addObserver(self, selector: #selector(subVCBackNeedRefresh), name: NSNotification.Name(rawValue: BUSINESS_LIST_REFRESH_NOTIFY), object: nil)
        
        reloadArray = [IndexPath]()
        
        //自定义对象读取
        let myModelData = userDefaults.data(forKey: "user_message")
        myModel = NSKeyedUnarchiver.unarchiveObject(with: myModelData!) as! UserEntity

        tableView.backgroundColor = Maco().RGBA(r: 242, g: 242, b: 242, a: 1)
        tableView.tableHeaderView?.backgroundColor = Maco().RGBA(r: 242, g: 242, b: 242, a: 1)
        
        self.setTableViewArr()
        
        self.getThis_month_unvisit()
        
        self.getUnfinishedNum()
        
        let cellNib = UINib(nibName: "UserTaskListTableViewCell", bundle: nil)

        tableView .register(cellNib, forCellReuseIdentifier: "UserTaskListTableViewCell")
        
    }
    
    func setTableViewArr() {
        
        
        if myModel.type_id != ROLE_CUSTOMER {
            
            sectionArray = [["title":"待办事项","icon":"待办事项","section":"",
                            "fistLeaf":[["title":" 特号办理","num":"t1+t2","viewController":"P_SpecialListViewController"],
                                        ["title":" 公司领导预约拜访","num":"t3","viewController":""],
                                        ["title":" 终端办理","num":"t4","viewController":""],
                                        ["title":" 终端退库","num":"t5","viewController":""],
                                        ["title":" 售后维修单","num":"t6+t7","viewController":""],
                                        ["title":" 台账登记","num":"t8+t9+t16","viewController":""],
                                        ["title":" 办卡","num":"t10+t11","viewController":""],
                                        ["title":" 开具发票","num":"t12+t13+t14","viewController":""],
                                        ["title":" 终端出库","num":"t15+t17","viewController":""],
                                        ["title":" 营销方案更改","num":"t18","viewController":""],
                                        ["title":" 退款","num":"t20","viewController":""],
                                        ["title":" 分合户","num":"t21","viewController":""],
                                        ["title":" 纵向行业任务协同","num":"t-1","viewController":""],
                                        ["title":" 进账查询","num":"t22","viewController":""]]],
                            ["title":"运营分析数据统计","icon":"运营信息统计icon","section":"1",
                             "fistLeaf":[["title":" 欠费催缴","viewController":""],
                                         ["title":" CRM业务办理情况","viewController":""],
                                         ["title":" 统一下单业务办理情况","viewController":""]]],
                            ["title":"小纸条","icon":"小纸条工单icon","section":"","viewController":"small_piece_paperViewController"],
                            ["title":"欠费任务提醒","icon":"催缴任务","section":"","viewController":"Payment_arrears_listViewController"],
                            ["title":"合同到期提醒推送","icon":"合同到期-2","section":"","viewController":"Contract_expiresViewController"],
                            ["title":"客户生日提醒","icon":"生日提醒(1)","section":"","viewController":"Birthday_listViewController"],
                            ["title":"APP应用推荐","icon":"业内应用推荐","section":"","viewController":"recommendedViewController"],
                            ["title":"推送设置","icon":"设置推送时间","section":"","viewController":"PushSettingViewController"],
                            ["title":"修改密码","icon":"修改密码","section":"","viewController":"ChangePwdViewController"],
                            ["title":"修改手机号码","icon":"my_phone","section":"","viewController":"ChangePhoneViewController"],
                            ["title":"意见反馈","icon":"意见反馈","section":"","viewController":"SuggestViewController"],
                            ["title":"App下载地址分享","icon":"my_share","section":"","viewController":"shareViewController"],
                            ["title":"当前版本","icon":"当前版本号","section":"","clientVersion":"","viewController":""]]
            
        }else{
            
            visitArray.add(["title":" 今天走访任务数","finish":"today_finish","total":"today"])
            visitArray.add(["title":" 本周走访任务数","finish":"this_week_finish","total":"this_week"])
            visitArray.add(["title":" 本月走访任务数","finish":"this_month_finish","total":"this_month"])
            visitArray.add(["title":" 上月走访任务数","finish":"last_month_finish","total":"last_month"])
            visitArray.add(["title":" 本月已走访集团客户","finish":"this_month_visited_num","total":"this_month_visit_total_num","secondLeaf":"1"])
            visitArray.add(["title":" 本月未走访集团客户","finish":"this_month_unvisit_num","total":"this_month_visit_total_num","secondLeaf":"2"])
            
            sectionArray = [["title":"待办事项","icon":"待办事项","section":"",
                             "fistLeaf":[["title":" 特号办理","num":"t1+t2","viewController":"P_SpecialListViewController"],
                                         ["title":" 公司领导预约拜访","num":"t3","viewController":""],
                                         ["title":" 终端办理","num":"t4","viewController":""],
                                         ["title":" 终端退库","num":"t5","viewController":""],
                                         ["title":" 售后维修单","num":"t6+t7","viewController":""],
                                         ["title":" 台账登记","num":"t8+t9+t16","viewController":""],
                                         ["title":" 办卡","num":"t10+t11","viewController":""],
                                         ["title":" 开具发票","num":"t12+t13+t14","viewController":""],
                                         ["title":" 终端出库","num":"t15+t17","viewController":""],
                                         ["title":" 营销方案更改","num":"t18","viewController":""],
                                         ["title":" 退款","num":"t20","viewController":""],
                                         ["title":" 分合户","num":"t21","viewController":""],
                                         ["title":" 纵向行业任务协同","num":"t-1","viewController":""],
                                         ["title":" 进账查询","num":"t22","viewController":""]]],
                            ["title":"走访情况","icon":"走访任务执行情况","section":"","fistLeaf":visitArray],
                            ["title":"运营分析数据统计","icon":"运营信息统计icon","section":"1",
                             "fistLeaf":[["title":" 欠费催缴","viewController":""],
                                         ["title":" CRM业务办理情况","viewController":""],
                                         ["title":" 统一下单业务办理情况","viewController":""]]],
                            ["title":"小纸条","icon":"小纸条工单icon","section":"","viewController":"small_piece_paperViewController"],
                            ["title":"欠费任务提醒","icon":"催缴任务","section":"","viewController":"Payment_arrears_listViewController"],
                            ["title":"合同到期提醒推送","icon":"合同到期-2","section":"","viewController":"Contract_expiresViewController"],
                            ["title":"客户生日提醒","icon":"生日提醒(1)","section":"","viewController":"Birthday_listViewController"],
                            ["title":"APP应用推荐","icon":"业内应用推荐","section":"","viewController":"recommendedViewController"],
                            ["title":"推送设置","icon":"设置推送时间","section":"","viewController":"PushSettingViewController"],
                            ["title":"修改密码","icon":"修改密码","section":"","viewController":"ChangePwdViewController"],
                            ["title":"修改手机号码","icon":"my_phone","section":"","viewController":"ChangePhoneViewController"],
                            ["title":"意见反馈","icon":"意见反馈","section":"","viewController":"SuggestViewController"],
                            ["title":"App下载地址分享","icon":"my_share","section":"","viewController":"shareViewController"],
                            ["title":"当前版本","icon":"当前版本号","section":"","viewController":"","clientVersion":""]]
            
        }
        
        
        sectionArray.add(["title":"退出登录","icon":"","section":""])

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == sectionArray.count - 1{
            
            let outBtnView = Bundle.main.loadNibNamed("UserLogoutBtnView", owner: nil, options: nil)?.first as! UserLogoutBtnView


            outBtnView.outBtn.layer.borderWidth = 1
            
            outBtnView.outBtn.layer.cornerRadius = 10
            
            outBtnView.outBtn.layer.borderColor = Maco().RGBA(r: 28, g: 135, b: 192, a: 1).cgColor
            
            outBtnView.outBtn.addTarget(self, action: #selector(logoutBtnClicked), for: UIControlEvents.touchUpInside)

            
            return outBtnView
            
        }else{
            let HeaderView = Bundle.main.loadNibNamed("UserTableCellHeaderView", owner: nil, options: nil)?.first as! UserTableCellHeaderView

            let dic:[String:Any] =  sectionArray.object(at: section) as! [String:Any]

            HeaderView.tag = section
            
            HeaderView.titleLbl.text = dic["title"] as? String
            
            HeaderView.iconImage.image = UIImage(named: dic["icon"] as! String)
            
            if dic.keys.contains("clientVersion"){
                
                HeaderView.down_rightImage.isHidden = true
                HeaderView.Versionlabel.isHidden = false
                HeaderView.Versionlabel.text = ClientVersion
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SingleTop))
            //设置手势点击数,单击击：点1下
            tapGesture.numberOfTapsRequired = 1
            
            tapGesture.numberOfTapsRequired = 1
            
            HeaderView.addGestureRecognizer(tapGesture)
            
            return HeaderView
        }
 
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dic:[String:Any] =  sectionArray.object(at: section) as! [String:Any]
        
        if dic.keys.contains("fistLeaf"){
            let key = String(describing: (section))

            if selectedDic.keys.contains(key) {
                
//                let secondArr:NSArray = dic["fistLeaf"] as! NSArray
                
//                let secondDic:[String:Any] = dic["fistLeaf"] as! [String:Any]
                
//                if secondDic.keys.contains("secondLeaf") {
//                    
//                    return (dic["fistLeaf"] as! NSArray).count + secondDic.count
//
//                }else{
                
                    return (dic["fistLeaf"] as! NSArray).count

//                }

            }else{
                return 0
            }
            
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == sectionArray.count - 1{
            
            return 80

        }else{
            
            return 50

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        let dic:[String:Any] =  sectionArray.object(at: section) as! [String:Any]

        if (dic["section"] as! String) == "1" {
         
            return 10
        
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:UserTaskListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserTaskListTableViewCell", for: indexPath) as! UserTaskListTableViewCell
        
        let dic:[String:Any] =  sectionArray.object(at: indexPath.section) as! [String:Any]
        
        if dic.keys.contains("fistLeaf"){
            
            let fistArr:NSArray = dic["fistLeaf"] as! NSArray

            let fistdic:[String:Any] =  fistArr.object(at: indexPath.row) as! [String:Any]
            
            if fistdic.keys.contains("secondLeaf") {

                if fistdic["secondLeaf"] as! String == "3" {
                    
                    let entity:This_month_unvisitEntity = fistdic["message"] as! This_month_unvisitEntity
                    
                    cell.titleLbl.text = entity.name
                    
                }else{
                    
                    cell.subTitleLbl.text = finishDic[fistdic["finish"] as! String]! + "/" + finishDic[fistdic["total"] as! String]!
                    
                    cell.titleLbl.text = fistdic["title"] as? String

                }
                
            }else{
                
                if fistdic.keys.contains("num"){
                    
                    var num = 0
                    
                    let arr:Array = ((fistdic["num"] as AnyObject).components(separatedBy: "+"))
                    
                    for key in arr{
                        num += Int((self.unfinishedDict[key] as! NSString).intValue)
                    }
                    
                    cell.subTitleLbl.text = "\(num)"
                    
                    if num > 0 {
                        cell.subTitleLbl.textColor = UIColor.red
                        
                    }else{
                        cell.subTitleLbl.textColor = UIColor.lightGray
                    }
                }else{
                    cell.subTitleLbl.text = "Label"
                }
                
                cell.titleLbl.text = fistdic["title"] as? String

            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let dic:[String:Any] =  sectionArray.object(at: indexPath.section) as! [String:Any]
        
        let fistArr:NSArray = dic["fistLeaf"] as! NSArray
        
        let fistdic:[String:Any] =  fistArr.object(at: indexPath.row) as! [String:Any]
        
        if fistdic.keys.contains("secondLeaf") {
            
            reloadArray.removeAll()
            
            //存储插入的位置
            
            if fistdic["secondLeaf"] as! String == "1"{
                
                if expandDic["1"]!{
                    
                    self.foldNodes(section: indexPath.section, currentIndex: indexPath.row, array: this_month_visitArr)
                    expandDic.updateValue(false, forKey: "1")
                    //删除cell
                    tableView.deleteRows(at: reloadArray, with: UITableViewRowAnimation.none)
                }else{
                    
                    for i in 0 ..< this_month_visitArr.count{
                        
                        reloadArray.append(IndexPath(row: indexPath.row + 1 + i, section: indexPath.section))
                        
                        visitArray.insert(["message":this_month_visitArr[i],"secondLeaf":"3"], at: indexPath.row + 1 + i)
                        expandDic.updateValue(true, forKey: "1")
                    }
                    
                    tableView.insertRows(at: reloadArray, with: UITableViewRowAnimation.none)
                }
              
            }else if fistdic["secondLeaf"] as! String == "2"{
                
                if expandDic["2"]!{
                    
                    self.foldNodes(section: indexPath.section, currentIndex: indexPath.row, array: this_month_unvisitArr)
                    expandDic.updateValue(false, forKey: "2")
                    //删除cell
                    tableView.deleteRows(at: reloadArray, with: UITableViewRowAnimation.none)
                    
                }else{
                    
                    for i in 0 ..< this_month_unvisitArr.count{
                        
                        reloadArray.append(IndexPath(row: indexPath.row + 1 + i, section: indexPath.section))
                        
                        visitArray.insert(["message":this_month_unvisitArr[i],"secondLeaf":"3"], at: indexPath.row + 1 + i)
                        expandDic.updateValue(true, forKey: "2")
                    }
                    
                    tableView.insertRows(at: reloadArray, with: UITableViewRowAnimation.none)
                }
              
            }else if fistdic["secondLeaf"] as! String == "3"{
                
                
                let vc = P_SpecialListViewController()
                
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
            

        }else{
            
            if fistdic.keys.contains("viewController") {
                
                let targetVC:String = fistdic["viewController"] as! String
                
                if targetVC.isEmpty {
                    
                    return
                }
                
                self.pushViwController(targetVC: targetVC)
            }
            
           
            
        }
        
    }
    
    func logoutBtnClicked() {
        
        let alertSheet = UIAlertController(title: "", message: "确认退出登录?", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertSheet.addAction(cancelAction)
        
        let otherAction = UIAlertAction(title: "退出登录", style: UIAlertActionStyle.default, handler: { (action) in
            
//            self.navigationController?.popToRootViewController(animated: true)

            let vc = LoginViewController()
            
            self.navigationController?.pushViewController(vc, animated: false)
            
        })
        
        alertSheet.addAction(otherAction)
        
        // 3 跳转
        self.present(alertSheet, animated: true, completion: nil)


    }
    
    func SingleTop(recognizer:UITapGestureRecognizer)  {
        
        let key = String(describing: (recognizer.view!.tag))
        
        let dic:[String:Any] =  sectionArray.object(at: recognizer.view!.tag) as! [String:Any]
        
        if dic.keys.contains("viewController"){
            
            if (dic["viewController"] as! String).isEmpty {
                
                return
            }
            self.pushViwController(targetVC: dic["viewController"] as! String)
            
        }else{

            if !selectedDic.keys.contains(key) {
                
                selectedDic.updateValue(1, forKey: key)
                
            }else{
                
                selectedDic.removeValue(forKey: key)
            }
            
            tableView.reloadSections(IndexSet(integer: recognizer.view!.tag), with: UITableViewRowAnimation.automatic)

        }
        
        
    }
    
    func getThis_month_unvisit() {
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"this_month_unvisit",
             "user_id":myModel.user_id,
             ]
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state")
            
            if (state as! NSString).intValue == 0{
            
        
            }else{
                
                let dic:NSDictionary = backMsg.object(forKey: "content") as! NSDictionary
                
                let this_month_visit_total_num = dic["total_num"] as! Int
                let this_month_visited_num = dic["visited_num"] as! Int
                let this_month_unvisit_num = dic["unvisit_num"] as! Int

                self.finishDic.updateValue(String(this_month_visit_total_num) , forKey: "this_month_visit_total_num")
                self.finishDic.updateValue(String(this_month_visited_num) , forKey: "this_month_visited_num")
                self.finishDic.updateValue(String(this_month_unvisit_num) , forKey: "this_month_unvisit_num")
                
                let visitedArr:NSArray = dic["visited"] as! NSArray
                let unvisitedArr:NSArray = dic["unvisit"] as! NSArray

                for attributes in visitedArr {
                    
                    let entity = This_month_unvisitEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    
                    self.this_month_visitArr.add(entity)
                }
                
                for attributes in unvisitedArr {
                    
                    let entity = This_month_unvisitEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    self.this_month_unvisitArr.add(entity)
                }
                
            }
            
            self.expandDic.updateValue(false, forKey: "1")
            self.expandDic.updateValue(false, forKey: "2")
            
            self.tableView.reloadData()
            
        }

        
    }
//MARK:代办事项的数据
    func getUnfinishedNum() {
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"getunfinishnum",
             "user_id":myModel.user_id,
             "user_type":myModel.type_id,
             "dep_id":myModel.dep_id,
             ]
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            if state == 1{
                self.unfinishedDict = backMsg.object(forKey: "content") as! NSDictionary
                
                var num = 0
                
                for key in self.unfinishedDict.allKeys{
                    
                    num += Int((self.unfinishedDict[key] as! NSString).intValue)
                    
                }
                
                if num > 0{
                    
                    self.tabBarItem.badgeValue = "\(num)"
                    
                }else{
                    
                    self.tabBarItem.badgeValue = nil
                
                }
                
            }else{
            
            }
        }
    }
    
    //MARK: 小纸条脚标
    func gettape_num() {
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"tape_num",
             "user_id":myModel.user_id,
             ]
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let tape_num = backMsg.object(forKey: "state") as! String
           
            print("\(tape_num)")
            
        }
    }

    //MARK:记录收起的数据
    func foldNodes(section : Int,currentIndex:Int,array:NSMutableArray){
        if currentIndex+1 < visitArray.count {
            
            let tempArr = NSArray(array: visitArray)
            
            let startI = currentIndex+1
            var endI   = currentIndex
            for i in (currentIndex+1)..<(tempArr.count) {

                if reloadArray.count >= array.count {
                    
                    break
                }
                
                endI += 1
                reloadArray.append(IndexPath(row: i, section: section))
                
            }

            
            if endI >= startI {
            
                visitArray.removeObjects(in: NSRange(location: startI, length: array.count))
            }
        }
    }

    func pushViwController(targetVC:String) {
        
        var NameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String
        
        NameSpace = NameSpace?.replacingOccurrences(of: "-", with: "_")
        
        let clsName = NameSpace! + "." + targetVC
        
        let model = NSClassFromString(clsName) as! UIViewController.Type
        
        let vc = model.init()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func subVCBackNeedRefresh() {
        
        self.getUnfinishedNum()
        
        self.gettape_num()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

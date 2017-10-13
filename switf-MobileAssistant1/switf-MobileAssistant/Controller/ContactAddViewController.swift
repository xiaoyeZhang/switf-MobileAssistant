//
//  ContactAddViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/18.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class ContactAddViewController: ZXYBaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,ContactAddViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var detailMuArr:NSMutableArray!
    
    var detailDic = Dictionary<String,String>()
    
    var compName:String = ""
    var compAddress:String = ""
    var kind:String = ""
    var type:String = ""
    var job:String = ""
    var tel:String = ""
    var IsMain:String = ""
    var IsMainLinkMan:String = ""
    var IsAddMember:String = ""
    var sex:String = ""
    var Age:String = ""
    var Address:String = ""
    var Edu:String = ""
    var Home:String = ""
    var Hobby:String = ""
    var name:String = ""
    var MemberLevel:String = ""
    var KernelLevel:String = ""
    
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "添加联系人"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        let submitBtn = self.setNaviRightBtnWithTitle(title: "提交")
        
        submitBtn.addTarget(self, action: #selector(submitBtnClicked), for: UIControlEvents.touchUpInside)
        
        self.initData()
        
        let cellNib = UINib(nibName: "TxtFieldTableViewCell", bundle: nil)
        
        tableView .register(cellNib, forCellReuseIdentifier: "TxtFieldTableViewCell")
        
//        tableView.keyboardDismissMode = .onDrag // tableView拖动，加盘下移
//        tableView.keyboardDismissMode =  .interactive // 向下拖动键盘视图键盘下移
    }

    func initData() {

        detailMuArr = [
            ["title":"集团名称：",    "type":"Push","message":"compName","placeholder":"请选择集团"],
            ["title":"集团地址：",    "type":"Label","message":"compAddress","placeholder":""],
            ["title":"成员种类：",    "type":"Select","message":"kind","SelectMess":"网内成员,网外成员","placeholder":""],
            ["title":"成员类型：",    "type":"Select","message":"type","SelectMess":"集团联系人,集团关键人","placeholder":""],
            ["title":"职       务：", "type":"Input","message":"job","placeholder":""],
            ["title":"电       话：", "type":"Input","message":"tel","placeholder":""],
            ["title":"主要成员：",    "type":"Select","message":"IsMain","SelectMess":"是,否","placeholder":""],
            ["title":"主要联系人：",   "type":"Select","message":"IsMainLinkMan","SelectMess":"是,否","placeholder":""],
            ["title":"添加集团\n成员：","type":"Select","message":"IsAddMember","SelectMess":"是,否","placeholder":""],
            ["title":"性       别：", "type":"Select","message":"sex","SelectMess":"男,女","placeholder":"请选择"],
            ["title":"年       龄：",  "type":"Input","message":"Age","placeholder":""],
            ["title":"住       址：",  "type":"Input","message":"Address","placeholder":""],
            ["title":"教育背景：",      "type":"Input","message":"Edu","placeholder":""],
            ["title":"家庭情况：",      "type":"Input","message":"Home","placeholder":""],
            ["title":"爱       好：",  "type":"Input","message":"Hobby","placeholder":""]]
        
        
        self.initMessageData()
        
    }
    
    func initMessageData(){
        
        for dic in detailMuArr{

            detailDic.updateValue("", forKey: (dic as! NSDictionary).object(forKey: "message") as! String)
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detailMuArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TxtFieldTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TxtFieldTableViewCell", for: indexPath) as! TxtFieldTableViewCell
        
        let dic:[String:String] =  detailMuArr!.object(at: indexPath.row) as! [String:String]
        
        cell.txtField.tag = indexPath.row
        cell.txtField.delegate = self
        
        cell.txtField.placeholder = dic["placeholder"]
        cell.titLabel.text = dic["title"]
        
        if detailDic.keys.contains(dic["message"]!){
            
            cell.txtField.text = detailDic[dic["message"]!]
            
        }else{
            
           detailDic.updateValue("", forKey: dic["message"]!)
        
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
                
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        let dic:[String:String] =  detailMuArr!.object(at: textField.tag) as! [String:String]
        
        detailDic.updateValue(textField.text!, forKey: dic["message"]!)
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return false
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        let dic:[String:String] =  detailMuArr!.object(at: textField.tag) as! [String:String]
        
        let type = dic["type"]
        
        if type == "Label" {
            
            return false
            
        }else if type == "Push"{
            
            let vc = CustomerViewController()
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            return false
        }else if type == "Select"{
            
            self.view.endEditing(true)
 
            let alertSheet = UIAlertController(title: dic["title"], message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
            
            alertSheet.addAction(cancelAction)
            
            let SelectArr:Array = (dic["SelectMess"]?.components(separatedBy: ","))!
            
            for Str in SelectArr{
                
                let otherAction = UIAlertAction(title: Str, style: UIAlertActionStyle.default, handler: { (action) in
                    
                    self.detailDic.updateValue(Str, forKey: dic["message"]!)
    
                    self.addForm(Str: Str)
                })
                
                alertSheet.addAction(otherAction)
            }
            
            
            // 3 跳转
            self.present(alertSheet, animated: true, completion: nil)
            
            return false
            
        }else{
            
            return true
        }
        
    }
    
    func submitBtnClicked() {
        
        self.sumbitMessage()
        
        let process=CommServer()

        if !detailDic.keys.contains("compNum") {
            
            self.ShowAlertCon(title: "警告", message: "集团不能为空", cancelTitle: "确定", popC: "0")
            
            return
        }
        
        if detailDic["tel"] == "" {
            
            self.ShowAlertCon(title: "警告", message: "手机号不能为空", cancelTitle: "确定", popC: "0")
            
            return
        }
        
        var parameters:[String:String] =
            ["method":"client_add_update",
             "Job":detailDic["job"]!,
             "OperType":"0",
             "PartyRoleId":type,
             "user_id":myModel.user_id,
             "GroupId":detailDic["compNum"]!,
             "MemberKind":kind,
             "c_type":"1",
             "user_num":myModel.num,
             "ServiceNum":detailDic["tel"]!,
             "IsMain":IsMain,
             "IsMainLinkMan":IsMainLinkMan,
             "IsAddMember":IsAddMember
             ]

        if detailDic.keys.contains("name"){
            
            if detailDic["name"] == "" {
                
                self.ShowAlertCon(title: "警告", message: "姓名不能为空", cancelTitle: "确定", popC: "0")
                
                return
            }
            
            parameters.updateValue(detailDic["name"]!, forKey: "CustName")
        
        }
        
        if type == "0" {
            
            parameters.updateValue(KernelLevel, forKey: "KernelLevel")
            parameters.updateValue(MemberLevel, forKey: "MemberLevel")
            
        }
        
        SVProgressHUD.show()
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state")
            
            if (state as! NSString).intValue == 1{
//                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                self.ShowAlertCon(title: "提示", message: "提交成功！", cancelTitle: "确定", popC: "1")
                
                self.add_Other_Data()
            
//                self.navigationController?.popViewController(animated: true)

            }else if (state as! NSString).intValue == -1
            {

                self.ShowAlertCon(title: "提示", message: backMsg.object(forKey: "msg") as! String, cancelTitle: "确定", popC: "0")

            }
            
            self.tableView.reloadData()

            SVProgressHUD.dismiss()
        }
        
    }
    
    func add_Other_Data() {
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"add_update_client_addition_info",
             "company_num":detailDic["compNum"]!,
             "tel":detailDic["tel"]!,
             "cl_sex":detailDic["sex"]!,
             "cl_age":detailDic["Age"]!,
             "cl_address":detailDic["Address"]!,
             "cl_edu":detailDic["Edu"]!,
             "cl_home":detailDic["Home"]!,
             "cl_hobby":detailDic["Hobby"]!
        ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state")
            
            if (state as! NSString).intValue == 1{
                
                
            }
            
            self.tableView.reloadData()
            
        }

    }
    
 
    func addForm(Str:String) {
        
        if Str == "网内成员"{
            
            kind = "1"
            
            detailMuArr.remove(["title":"姓       名：","type":"Input","message":"name","placeholder":""])
            
        }else if Str == "网外成员"{
            
            kind = "3"
            
            let array = [["title":"姓       名：","type":"Input","message":"name","placeholder":""]]

            var range = NSRange()
            
            if self.detailDic["type"] == "集团关键人"{
            
                range = NSMakeRange(6, array.count)
                
            }else{
                range = NSMakeRange(4, array.count)
            }
            
            let indexSet = NSIndexSet(indexesIn: range)
            
            if detailMuArr.contains(["title":"姓       名：","type":"Input","message":"name","placeholder":""]){
                
            }else{
                
                detailMuArr.insert(array, at: indexSet as IndexSet)

            }
            
            
        }else if Str == "集团联系人"{
           
            type = "1"
            
            detailMuArr.remove(
                ["title":"成员类别：","type":"Select","message":"MemberLevel","SelectMess":"高层领导/管理层,中层领导/影响力人物,最高领导,通讯部负责人,信息化部门负责人","placeholder":"请选择"])
            detailMuArr.remove(["title":"人物级别：","type":"Select","message":"KernelLevel","SelectMess":"无,集团1级,集团2级,集团3级,关系A,关系B,关系C","placeholder":"请选择"])
        }else if Str == "集团关键人"{
         
            type = "0"
            
            let array = [
                ["title":"成员类别：","type":"Select","message":"MemberLevel","SelectMess":"高层领导/管理层,中层领导/影响力人物,最高领导,通讯部负责人,信息化部门负责人","placeholder":"请选择"],
                ["title":"人物级别：","type":"Select","message":"KernelLevel","SelectMess":"无,集团1级,集团2级,集团3级,关系A,关系B,关系C","placeholder":"请选择"]]
            
            let range = NSMakeRange(4, array.count)

            let indexSet = NSIndexSet(indexesIn: range)
            
            print("\(detailMuArr.contains(array))")
            
            if detailMuArr.contains(["title":"成员类别：","type":"Select","message":"MemberLevel","SelectMess":"高层领导/管理层,中层领导/影响力人物,最高领导,通讯部负责人,信息化部门负责人","placeholder":"请选择"]) {
                
            }else{
                
                detailMuArr.insert(array, at: indexSet as IndexSet)
                
            }
            
        }
        
        self.tableView.reloadData()
    }
    
    func sumbitMessage() {
        
        if detailDic["IsMain"] == "是" {
            IsMain = "0"
        }else if detailDic["IsMain"] == "否" {
            IsMain = "1"
        }else if detailDic["IsMainLinkMan"] == "是" {
            IsMainLinkMan = "0"
        }else if detailDic["IsMainLinkMan"] == "否" {
            IsMainLinkMan = "1"
        }else if detailDic["IsAddMember"] == "是" {
            IsAddMember = "0"
        }else if detailDic["IsAddMember"] == "否" {
            IsAddMember = "1"
        }else if detailDic.keys.contains("MemberLevel"){
            
            if detailDic["MemberLevel"] == "高层领导/管理层" {
                MemberLevel = "2"

            }else if detailDic["MemberLevel"] == "中层领导/影响力人物" {
                MemberLevel = "3"
            }else if detailDic["MemberLevel"] == "最高领导" {
                MemberLevel = "5"
            }else if detailDic["MemberLevel"] == "通讯部负责人" {
                MemberLevel = "6"
            }else if detailDic["MemberLevel"] == "信息化部门负责人" {
                MemberLevel = "10"
            }
            
        }else if detailDic.keys.contains("KernelLevel"){
            if detailDic["KernelLevel"] == "无" {
                KernelLevel = "0"
            }else if detailDic["KernelLevel"] == "集团1级" {
                KernelLevel = "1"
            }else if detailDic["KernelLevel"] == "集团2级" {
                KernelLevel = "2"
            }else if detailDic["KernelLevel"] == "集团3级" {
                KernelLevel = "3"
            }else if detailDic["KernelLevel"] == "关系A" {
                KernelLevel = "4"
            }else if detailDic["KernelLevel"] == "关系B" {
                KernelLevel = "5"
            }else if detailDic["KernelLevel"] == "关系C" {
                KernelLevel = "6"
            }
        }
    }
    
    func SelectCompany(entity:CompEntity) {
        
        self.detailDic.updateValue(entity.name!, forKey: "compName")
        self.detailDic.updateValue(entity.address!, forKey: "compAddress")
        self.detailDic.updateValue(entity.num!, forKey: "compNum")
        
        self.tableView.reloadData()
        
    }
    
    func keyboardWillShow(notification:NSNotification) {
        
        let keyInfo:NSDictionary = notification.userInfo! as NSDictionary
        
        var keyboardFrame:CGRect = (keyInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        keyboardFrame = self.tableView.convert(keyboardFrame, from: nil)
        
        let intersect = keyboardFrame.intersection(self.tableView.bounds)
        
        if !intersect.isNull {
            let duration = keyInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
            UIView.animate(withDuration: duration, animations: {
                
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: intersect.size.height + 10, right: 0)
                self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: intersect.size.height + 10, right: 0)
            })
        }
    }

    func keyboardWillHide(notification:NSNotification) {
        
        let keyInfo:NSDictionary = notification.userInfo! as NSDictionary
        let duration = keyInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        UIView.animate(withDuration: duration, animations: {
            self.tableView.contentInset = UIEdgeInsets.zero
            self.tableView.scrollIndicatorInsets = UIEdgeInsets.zero
        })
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

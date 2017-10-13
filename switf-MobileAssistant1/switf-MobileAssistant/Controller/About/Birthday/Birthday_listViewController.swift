
//
//  Birthday_listViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/11.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Birthday_listViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,successBirthday_departmentdelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldKey: UITextField!
    
    var arrayCutomer:NSMutableArray = []
    var arrayCutomerTemp:NSMutableArray = []
    
    var Dep_id = "-1"
    
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "生日提醒"
        
        let RightBtn = self.setNaviRightBtnWithTitle(title: "筛选")
        
        RightBtn.addTarget(self, action: #selector(search_Click), for: UIControlEvents.touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(subVCBackNeedRefresh), name: NSNotification.Name(rawValue: BUSINESS_LIST_REFRESH_NOTIFY), object: nil)
        
        let cellNib = UINib(nibName: "Birthday_NewsTableViewCell", bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: "Birthday_NewsTableViewCell")
        
        self.getData(query: "", dep_id: Dep_id)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if section == 0 {
            return arrayCutomer.count
        }else{
            return arrayCutomerTemp.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 30))
        headView.backgroundColor = Maco().RGBA(r: 240, g: 240, b: 240, a: 1)
        let headLabel = UILabel(frame: CGRect(x: 10, y: 5, width: 100, height: 20))
        headLabel.font = UIFont.systemFont(ofSize: 15)
        
        if section == 0 {
            headLabel.text = "本周内"
        }else{
            headLabel.text = "一个月内"
        }
        headView.addSubview(headLabel)
        
        return headView
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Birthday_NewsTableViewCell", for: indexPath) as! Birthday_NewsTableViewCell
        
        var entity:Birthday_listEntity
        
        if indexPath.section == 0{
            entity = arrayCutomer.object(at: indexPath.row) as! Birthday_listEntity

        }else{
            entity = arrayCutomerTemp.object(at: indexPath.row) as! Birthday_listEntity
        }
        
        cell.labelTitle.text = entity.client_name! + "(" + entity.company_name! + ")"
        
        cell.labelDate.text = "距离生日" + entity.date! + "天"

        if entity.state == "-1" {
            cell.typeLabel.text = "未发送短信"
        }else if entity.state == "0" {
            cell.typeLabel.text = "已发送"
        }else if entity.state == "1" {
            cell.typeLabel.text = "定时发送"
        }


        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        var entity:Birthday_listEntity
        
        if indexPath.section == 0{
            entity = arrayCutomer.object(at: indexPath.row) as! Birthday_listEntity
            
        }else{
            entity = arrayCutomerTemp.object(at: indexPath.row) as! Birthday_listEntity
        }

        let vc = Birthday_DetailViewController()
        
        vc.birthday_id = entity.birthday_id!
        
        vc.getData()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.textFieldKey.resignFirstResponder()
        
    }
    
    func getData(query:String,dep_id:String) {
        
        SVProgressHUD.show()
        
        let process=CommServer()

        let parameters:[String:String] = ["method":"get_birthday_list",
                                          "user_num":myModel.num,
                                          "query":query,
                                          "dep_id":dep_id]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            self.arrayCutomer.removeAllObjects()
            self.arrayCutomerTemp.removeAllObjects()
            
            if state == 1 {

                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                for attributes in array {
                    
                    let entity = Birthday_listEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)

                    if entity.birthday_type == "1"{
                     
                        self.arrayCutomer.add(entity)

                    }else{
                        self.self.arrayCutomerTemp.add(entity)

                    }
                    
                }
            }else{

                
            }
            
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        self.textFieldKey.resignFirstResponder()
        
        self.getData(query: self.textFieldKey.text!, dep_id: Dep_id)
    
        return false
    }
    
    func search_Click() {
        
        let vc = Birthday_departmentViewController()
        
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func successBirthday_department(successdelegate: NSDictionary) {
        
        Dep_id = successdelegate.object(forKey: "dep_id") as! String
        
        self.getData(query: "", dep_id: Dep_id)
        
    }
    
    
    @IBAction func doSelectByKey(_ sender: UIButton) {
        
        self.textFieldKey.resignFirstResponder()
        
        self.getData(query: self.textFieldKey.text!, dep_id: Dep_id)
    }

    func subVCBackNeedRefresh() {
        
        self.getData(query: "", dep_id: Dep_id)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class Birthday_listEntity: NSObject {
    
    
    var birthday_id:String?
    var birthday_type:String?
    var company_name:String?
    var client_name:String?
    var date:String?
    var state:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.birthday_id = backMsg.object(forKey: "birthday_id") as? String
        self.birthday_type = backMsg.object(forKey: "birthday_type") as? String
        self.company_name = backMsg.object(forKey: "company_name") as? String
        self.client_name = backMsg.object(forKey: "client_name") as? String
        self.date = backMsg.object(forKey: "date") as? String
        self.state = backMsg.object(forKey: "state") as? String
    }
    
}

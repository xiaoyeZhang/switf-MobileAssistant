//
//  Contract_expiresViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/12.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Contract_expiresViewController: ZXYBaseViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldKey: UITextField!
    
    var arrayCutomer:NSMutableArray = []
    var arrayCutomerTemp:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "合同到期提醒"
        
        let cellNib = UINib(nibName: "Birthday_NewsTableViewCell", bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: "Birthday_NewsTableViewCell")
        
        self.getData(company_name: "")
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
            headLabel.text = "一个月后"
        }
        headView.addSubview(headLabel)
        
        return headView
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Birthday_NewsTableViewCell", for: indexPath) as! Birthday_NewsTableViewCell
        
        var entity:Contract_listEntity
        
        if indexPath.section == 0{
            entity = arrayCutomer.object(at: indexPath.row) as! Contract_listEntity
            
        }else{
            entity = arrayCutomerTemp.object(at: indexPath.row) as! Contract_listEntity
        }
        
        cell.labelTitle.text = entity.company_name
        
        cell.labelDate.text = "(" + entity.title! + ")"
        
        cell.typeLabel.text = "详情查看"
        cell.typeLabel.textColor = Maco().RGBA(r: 16, g: 66, b: 199, a: 1)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        var entity:Contract_listEntity
        
        if indexPath.section == 0{
            entity = arrayCutomer.object(at: indexPath.row) as! Contract_listEntity
            
        }else{
            entity = arrayCutomerTemp.object(at: indexPath.row) as! Contract_listEntity
        }
        
        let vc = Contract_expries_DetailViewController()
        
        vc.contract_id = entity.contract_id!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.textFieldKey.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.textFieldKey.resignFirstResponder()
        
        self.getData(company_name: self.textFieldKey.text!)
        
        return false
    }
    
    func getData(company_name:String) {
        
        SVProgressHUD.show()
        
        let process=CommServer()
        
        let parameters:[String:String] = ["method":"get_contract_list",
                                          "user_num":myModel.num,
                                          "company_name":company_name]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            self.arrayCutomer.removeAllObjects()
            self.arrayCutomerTemp.removeAllObjects()
            
            if state == 1 {
                
                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                for attributes in array {
                    
                    let entity = Contract_listEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    
                    if entity.list_type == "1"{
                        
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
    
    @IBAction func doSelectByKey(_ sender: UIButton) {
        self.textFieldKey.resignFirstResponder()
        
        self.getData(company_name: self.textFieldKey.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: 实体类
class Contract_listEntity: NSObject {
    
    var end_time:String?
    var title:String?
    var list_type:String?
    var contract_id:String?
    var company_name:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.end_time = backMsg.object(forKey: "end_time") as? String
        self.title = backMsg.object(forKey: "title") as? String
        self.list_type = backMsg.object(forKey: "list_type") as? String
        self.contract_id = backMsg.object(forKey: "contract_id") as? String
        self.company_name = backMsg.object(forKey: "company_name") as? String
    }
    
}

//
//  Payment_arrears_listViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/12.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Payment_arrears_listViewController: ZXYBaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldKey: UITextField!
    
    var arrayCutomer:NSMutableArray = []
    
    var company_name = ""
    var company_num = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "欠费任务提醒"
        
        let cellNib = UINib(nibName: "Birthday_NewsTableViewCell", bundle: nil)
        
        self.tableView.register(cellNib, forCellReuseIdentifier: "Birthday_NewsTableViewCell")
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayCutomer.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Birthday_NewsTableViewCell", for: indexPath) as! Birthday_NewsTableViewCell
  
        let entity:Payment_arrears_listEntity = arrayCutomer.object(at: indexPath.row) as! Payment_arrears_listEntity
        
        cell.typeLabel.alpha = 0;
        cell.labelTitle.text = entity.company_name
        cell.labelDate.text = "(欠费金额 " + entity.sum! + ")"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let entity:Payment_arrears_listEntity = arrayCutomer.object(at: indexPath.row) as! Payment_arrears_listEntity
        
        let vc = Arrears_taskViewController()
        
        vc.company_name = entity.company_name!
        vc.company_num = entity.company_num!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        self.textFieldKey.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.textFieldKey.resignFirstResponder()
        
        if self.isPureNumandCharacters(string: self.textFieldKey.text!) {
            
            company_num = self.textFieldKey.text!
        }else{
            company_name = self.textFieldKey.text!
        }
        
        self.getData()
        
        return false
    }
    
    func getData() {
        
        SVProgressHUD.show()
        
        let process=CommServer()
        
        var parameters:[String:String] = ["method":"get_arrearage_list"]
        
        parameters.updateValue(myModel.num, forKey: "user_num")
        
        if company_name.characters.count != 0{
            parameters.updateValue(company_name, forKey: "company_name")
        }
        
        if company_num.characters.count != 0{
            parameters.updateValue(company_num, forKey: "company_num")
        }
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            self.arrayCutomer.removeAllObjects()
            
            if state == 1 {
                
                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                for attributes in array {
                    
                    let entity = Payment_arrears_listEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    
                    self.arrayCutomer.add(entity)
                    
                }
                
            }else{
                
                
            }
            
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }

    
    @IBAction func doSelectByKey(_ sender: UIButton) {
   
        self.view.endEditing(true)
        
        if self.isPureNumandCharacters(string: self.textFieldKey.text!) {
            
            company_num = self.textFieldKey.text!
        }else{
            company_name = self.textFieldKey.text!
        }
        
        self.getData()
        
    }
    
    //MARK:判断是否全数字
    func isPureNumandCharacters(string:String) -> Bool {
        
        var res = true
        
        let tmpSet = NSCharacterSet.init(charactersIn: "0123456789")
        
        var i:Int = 0
        
        while i < string.characters.count {
            let ns3=(string as NSString).substring(with: NSMakeRange(i, 1))
            
            let range:NSRange = (ns3 as NSString).rangeOfCharacter(from: tmpSet as CharacterSet)
            
            if range.length == 0{
                res = false
                break
            }
            
            i += 1
        }
        
        return res
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//MARK: 实体类
class Payment_arrears_listEntity: NSObject {
    
    var company_num:String?
    var company_name:String?
    var sum:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.company_num = backMsg.object(forKey: "company_num") as? String
        self.company_name = backMsg.object(forKey: "company_name") as? String
        self.sum = backMsg.object(forKey: "sum") as? String

    }
    
}

//
//  Birthday_departmentViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/12.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

protocol successBirthday_departmentdelegate: class {
    
    func successBirthday_department(successdelegate:NSDictionary)
    
}

class Birthday_departmentViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate:successBirthday_departmentdelegate?
    
    var arrayCutomer:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "集团列表"
        
        let cellNib = UINib(nibName: "Birthday_NewsTableViewCell", bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: "Birthday_NewsTableViewCell")
        
        self.getData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayCutomer.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "Birthday_NewsTableViewCell", for: indexPath) as! Birthday_NewsTableViewCell
        
        
        cell.labelTitle.text = (arrayCutomer.object(at: indexPath.row) as! Dictionary)["name"]
        cell.labelDate.text = ""
        cell.typeLabel.text = ""
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        tableView.deselectRow(at: indexPath, animated: true)

        //调用代理方法
        if((delegate) != nil)
        {
            delegate?.successBirthday_department(successdelegate: arrayCutomer.object(at: indexPath.row) as! NSDictionary)
            
            self.navigationController?.popViewController(animated: true)
        }

    }
    
    
    func getData() {
        SVProgressHUD.show()
        
        let process=CommServer()
        
        let parameters:[String:String] = ["method":"get_dep_list",
                                          "user_id":myModel.user_id]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! String
            
            if state == "1" {
            
                self.arrayCutomer = backMsg.object(forKey: "content") as! NSArray
            
            }
            
            self.tableView.reloadData()
            
            SVProgressHUD.dismiss()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}

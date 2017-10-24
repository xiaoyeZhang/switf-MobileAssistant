//
//  CustomerViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/8.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

protocol ContactAddViewControllerDelegate: class {
    
    func SelectCompany(entity:CompEntity)
    
}

class CustomerViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textFieldKey: UITextField!
    
    var delegate:ContactAddViewControllerDelegate?
    
    var arrayCustomerTemp:NSMutableArray = []
    var arrayCutomer:NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "选择集团"

        tableView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: "SwiftCell")
        
        self.getData()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayCutomer.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 55
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
//        let cellID : String = "SwiftCell"
//
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as UITableViewCell!
//
//        //检测，拿到一个可用的cell
//        if(cell == nil)
//        {
//            
//            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellID)
//            
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftCell", for: indexPath)

        let entity = self.arrayCutomer.object(at: indexPath.row) as! CompEntity
        
        cell.textLabel?.text =  entity.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let entity = self.arrayCutomer.object(at: indexPath.row) as! CompEntity
        
        //调用代理方法
        if((delegate) != nil)
        {
            delegate?.SelectCompany(entity: entity)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func getData() {
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"company_list",
             "user_num":myModel.num,
             "user_id":myModel.user_id,
             "is_first":myModel.is_first,
             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state")
            
            if (state as! NSString).intValue == 1{
                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                for attributes in array {
                    
                    let entity = CompEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    
                    self.arrayCutomer.add(entity)
                    
                    self.arrayCustomerTemp.add(entity)
                }
                
            }
            
            self.tableView.reloadData()
            
        }


    }
    
    
    @IBAction func doSelectByKey(_ sender: UIButton) {
    
        self.view.endEditing(true)
        
        self.arrayCutomer.removeAllObjects()
        
        
        let strKey = textFieldKey.text! as NSString
        
        if strKey.length == 0 {
            
            for i in 0  ..< arrayCustomerTemp.count  {
                
                let entity = self.arrayCustomerTemp.object(at: i) as! CompEntity
                
                arrayCutomer.add(entity)
                
            }
            
            self.tableView.reloadData()
            return
        }
        
        for i in 0 ..< arrayCustomerTemp.count {
            
            let entity = self.arrayCustomerTemp.object(at: i) as! CompEntity
            
            let range = entity.name?.range(of: strKey as String)
            
            if (range != nil) {
                
                arrayCutomer.add(entity)
                
            }
            
        }
        
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

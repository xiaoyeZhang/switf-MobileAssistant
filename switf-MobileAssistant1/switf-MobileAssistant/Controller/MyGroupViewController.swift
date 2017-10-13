//
//  MyGroupViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/18.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class MyGroupViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var mutableArry:NSMutableArray = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "我的集团"

        let cellNib = UINib(nibName: "MyGroupTableViewCell", bundle: nil)
        
        tableView .register(cellNib, forCellReuseIdentifier: "MyGroupTableViewCell")
        
        self.getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mutableArry.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 127
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MyGroupTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyGroupTableViewCell", for: indexPath) as! MyGroupTableViewCell
        
        cell.bgView.layer.cornerRadius = 5
        cell.bgView.layer.borderWidth = 1
        cell.bgView.layer.borderColor = Maco().RGBA(r: 225, g: 225, b: 225, a: 1).cgColor
        
        let entity = self.mutableArry.object(at: indexPath.row) as! CompEntity
        
        cell.GroupName.text = entity.name
        cell.GroupNum.text = "集团编号：" + entity.num!
        cell.GroupAddress.text = "集团地址：" + entity.address!
        cell.GroupType.text = "集团类型：" + Maco().setLevel(company_level: entity.company_level! as NSString)
        
        var company_staty:String = ""
        
        if entity.company_status == "0"{
        
            company_staty = "正使用集团客户"
            
        }else{
            company_staty = "未开户集团客户"
        }
        
        let str:NSMutableAttributedString = NSMutableAttributedString(string: "集团状态：\(company_staty)")
        
        str.addAttribute(NSForegroundColorAttributeName, value: Maco().RGBA(r: 52, g: 160, b: 213, a: 1), range: NSRange.init(location: 5, length:str.length - 5))
        
        cell.GroupState.attributedText = str
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
//        let entity = self.mutableArry.object(at: indexPath.row) as! CompEntity
        
        
        
    }
    
    func getData() {
        
        let process=CommServer()

        let parameters:[String:String] =
            ["method":"company_list",
             "user_num":myModel.num,
             "user_id":myModel.user_id,
             "is_first":myModel.is_first,
             ]
        
        SVProgressHUD.show()
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") 
            
            if (state as! NSString).intValue == 1{
                let array:NSArray = backMsg.object(forKey: "content") as! NSArray

                for attributes in array {
                    
                    let entity = CompEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    
                    self.mutableArry.add(entity)
                    
                }
                
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

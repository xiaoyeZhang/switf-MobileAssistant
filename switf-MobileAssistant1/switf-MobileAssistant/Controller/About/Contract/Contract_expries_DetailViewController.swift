//
//  Contract_expries_DetailViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/12.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Contract_expries_DetailViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var detailMuArr:NSArray = []
    
    var dic:[String:String] = [:]
    
    var contract_id = ""
    
    var cellHeight:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "合同详情"
        
        let cellNib = UINib(nibName: "TwoLablesTableViewCell", bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: "TwoLablesTableViewCell")
        
        
        detailMuArr = [["title":"集团名称:","message":"company_name"],
                       ["title":"集团编号:","message":"company_num"],
                       ["title":"合同系列号:","message":"contract_sn"],
                       ["title":"合同名称:","message":"contract_name"],
                       ["title":"生效时间:","message":"start_time"],
                       ["title":"失效时间:","message":"end_time"]]
        
        tableView.tableFooterView = UIView()
        
        self.getData()
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return detailMuArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return CGFloat(cellHeight + 20)
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwoLablesTableViewCell", for: indexPath) as! TwoLablesTableViewCell
        
        let dic:[String:String] =  detailMuArr.object(at: indexPath.row) as! [String:String]
        
        cell.titleLabel.text = dic["title"]
        
        if self.dic.count > 0{
            
            cell.subTitleLbl.text = self.dic[dic["message"]!]
            
        }
        
        cellHeight = self.heightForString(value: cell.subTitleLbl.text!, fontSize: 16, width: Float(cell.subTitleLbl.frame.size.width))
        
        return cell
    }
    
    func getData() {
        
        SVProgressHUD.show()
        
        let process=CommServer()
        
        let parameters:[String:String] = ["method":"get_contract_detail",
                                          "contract_id":contract_id]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            if state == 1 {
                
                self.dic = backMsg.object(forKey: "content") as! [String : String]
                
            }else{
                
                
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

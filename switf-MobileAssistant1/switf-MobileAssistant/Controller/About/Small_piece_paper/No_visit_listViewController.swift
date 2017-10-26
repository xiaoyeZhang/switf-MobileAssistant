//
//  No_visit_listViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/24.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

protocol No_visit_listViewControllerDelegate: class {
    
    func setCustomer(ex:NSMutableArray)
    
}

class No_visit_listViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate:No_visit_listViewControllerDelegate?
    
    var arrayCutomer:NSMutableArray = []
    var deleteArr:NSMutableArray = []
    //存储选中单元格的索引
    var selectedIndexs = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "选择客户经理"
        
//        tableView.isEditing = true
        
        tableView.allowsMultipleSelectionDuringEditing = true  //可编辑多选
        
        let addBtn = self.setNaviRightBtnWithTitle(title: "确定")
        
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: UIControlEvents.touchUpInside)
        
        self.getData()
    }

    func addBtnClicked() {
        //调用代理方法
        if((delegate) != nil)
        {
            delegate?.setCustomer(ex: deleteArr)
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayCutomer.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID : String = "cell"

        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as UITableViewCell!

        //检测，拿到一个可用的cell
        if(cell == nil)
        {

            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellID)

        }
        let entity:No_visit_listEntity = arrayCutomer.object(at: indexPath.row) as! No_visit_listEntity
        
        cell?.textLabel?.text = entity.name
        
        if selectedIndexs.contains(indexPath.row) {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        //MARK:非编辑状态下的多选
        
        let cell = self.tableView?.cellForRow(at: indexPath)
        
        cell?.accessoryType = .none
        
        let entity:No_visit_listEntity = arrayCutomer.object(at: indexPath.row) as! No_visit_listEntity
        
        deleteArr.remove(entity)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let entity:No_visit_listEntity = arrayCutomer.object(at: indexPath.row) as! No_visit_listEntity
//MARK:实际单选的多选

        if let index = selectedIndexs.index(of: indexPath.row){
           
            selectedIndexs.remove(at: index) //原来选中的取消选中
            deleteArr.remove(entity)
        
        }else{
            
            selectedIndexs.append(indexPath.row) //原来没选中的就选中

            deleteArr.add(entity)

        }
        //刷新该行
        self.tableView?.reloadRows(at: [indexPath], with: .automatic)

        //MARK:编辑状态下的多选
        
//        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
//       
//        deleteArr.add(entity)
//
        
    }
    
    func getData() {
        
        SVProgressHUD.show()
        
        let process=CommServer()

        let parameters:[String:String] = ["method":"userinfo",
                                          "dep_id":myModel.dep_id,
                                          "type_id":myModel.type_id]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            if state == 1 {
                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                for attributes in array {
                    
                    let entity = No_visit_listEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    
                    self.arrayCutomer.add(entity)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: 实体类
class No_visit_listEntity: NSObject {

    var num:String?
    var name:String?
    var user_id:String?
    
    var tel:String?

    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.num = backMsg.object(forKey: "num") as? String
        self.name = backMsg.object(forKey: "name") as? String
        self.user_id = backMsg.object(forKey: "user_id") as? String
        
        self.tel = backMsg.object(forKey: "tel") as? String

    }
    
}


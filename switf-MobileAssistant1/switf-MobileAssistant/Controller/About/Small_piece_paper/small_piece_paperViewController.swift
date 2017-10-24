//
//  small_piece_paperViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/13.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class small_piece_paperViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var No_reply: UIButton!
    @IBOutlet weak var Already_reply: UIButton!
    @IBOutlet weak var no_replyNum: UILabel!
    @IBOutlet weak var Already_replyNum: UILabel!
    
    var tape_num = 0
    
    
    var unreply = ""
    
    var no_replyArr:NSMutableArray = []
    var Already_replyArr:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "小纸条"
        
        let cellNib = UINib(nibName: "Small_prece_paperTableViewCell", bundle: nil)
        
        tableView.register(cellNib, forCellReuseIdentifier: "Small_prece_paperTableViewCell")
        
        unreply = "0"
        
        self.no_replyNum.alpha = 0
        self.Already_replyNum.alpha = 0

        self.No_reply.layer.borderWidth = 1
        self.Already_reply.layer.borderWidth = 1

        self.No_reply.layer.borderColor = Maco().RGBA(r: 66, g: 187, b: 233, a: 1).cgColor
        self.Already_reply.layer.borderColor = Maco().RGBA(r: 66, g: 187, b: 233, a: 1).cgColor

        self.No_reply.backgroundColor = Maco().RGBA(r: 66, g: 187, b: 233, a: 1)
        
        self.No_reply.setTitleColor(UIColor.white, for: UIControlState.normal)
        
        let No_replyPath = UIBezierPath(roundedRect: No_reply.bounds, byRoundingCorners: [UIRectCorner.bottomLeft,UIRectCorner.topLeft], cornerRadii: CGSize(width: 5, height: 5))
        let No_replyLayer = CAShapeLayer()
        No_replyLayer.frame = self.No_reply.bounds
        No_replyLayer.path = No_replyPath.cgPath
        No_reply.layer.mask = No_replyLayer
        
        
        let Already_replyPath = UIBezierPath(roundedRect: Already_reply.bounds, byRoundingCorners: [UIRectCorner.bottomRight,UIRectCorner.topRight], cornerRadii: CGSize(width: 5, height: 5))
        let Already_replyLayer = CAShapeLayer()
        Already_replyLayer.frame = self.Already_reply.bounds
        Already_replyLayer.path = Already_replyPath.cgPath
        Already_reply.layer.mask = Already_replyLayer
        
        self.gettape_num()
        
        self.setTape_num()
        
        self.getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if unreply == "0" {
            return no_replyArr.count;
        }else if unreply == "1"{
            return Already_replyArr.count;
            
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 125
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Small_prece_paperTableViewCell", for: indexPath) as! Small_prece_paperTableViewCell
          
        cell.backgroundColor = Maco().RGBA(r: 242, g: 242, b: 242, a: 1)
        
        cell.bgView.layer.borderWidth = 1
        cell.bgView.layer.borderColor = Maco().RGBA(r: 225, g: 225, b: 225, a: 1).cgColor
        
        var entity:small_piece_paperEntity
        
        if unreply == "0"{
            entity = no_replyArr.object(at: indexPath.row) as! small_piece_paperEntity
            
        }else{
            entity = Already_replyArr.object(at: indexPath.row) as! small_piece_paperEntity
        }

        cell.titleLabel.text = "主题：" + entity.title!

        if entity.isnew == "0" {
            cell.isNewLabel.alpha = 0
        }else if entity.isnew == "1"{
            cell.isNewLabel.alpha = 1
        }else{
            
        }
        
        cell.messageLabel.text = "内容：" + entity.content!
      
        cell.nameLabel.text = "客户经理姓名：" + entity.user_name!
        cell.timeLabel.text = "发送时间：" + entity.create_time!
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 18))
        label.text = cell.titleLabel.text
        
        let size = label.sizeThatFits(CGSize(width: label.frame.size.width, height: CGFloat(MAXFLOAT)))


        if (entity.img_name?.characters.count)! > 0 {
            
            cell.iconImage.isHidden = false
            
            cell.iconImage.frame = CGRect(x: size.width + cell.titleLabel.frame.origin.x+3, y: 15, width: 18, height: 18)
            
        }else{
            
            cell.iconImage.isHidden = true
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        
        var entity:small_piece_paperEntity
        
        if unreply == "0"{
            entity = no_replyArr.object(at: indexPath.row) as! small_piece_paperEntity
            
        }else{
            entity = Already_replyArr.object(at: indexPath.row) as! small_piece_paperEntity
        }

        self.doTape_read(tape_id: entity.tape_id!)
        
        let vc = small_piece_paperDetailViewController()
        vc.entity = entity
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func changeState(_ sender: UIButton) {
        
        if sender.tag == 0 {
            unreply = "0"
            
            No_reply.backgroundColor = Maco().RGBA(r: 66, g: 187, b: 233, a: 1)
            No_reply.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            Already_reply.backgroundColor = Maco().RGBA(r: 242, g: 242, b: 242, a: 1)
            Already_reply.setTitleColor(Maco().RGBA(r: 66, g: 187, b: 233, a: 1), for: UIControlState.normal)
        }
        
        
        if sender.tag == 1{
            unreply = "1"
            
            Already_reply.backgroundColor = Maco().RGBA(r: 66, g: 187, b: 233, a: 1)
            Already_reply.setTitleColor(UIColor.white, for: UIControlState.normal)
            
            No_reply.backgroundColor = Maco().RGBA(r: 242, g: 242, b: 242, a: 1)
            No_reply.setTitleColor(Maco().RGBA(r: 66, g: 187, b: 233, a: 1), for: UIControlState.normal)
        }
        
        self.getData()
    }
    
    func addBtnClicked() {
        
        let vc = small_piece_paperSubmitViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func setTape_num() {
        
        if myModel.type_id == ROLE_CUSTOMER{
            
            if self.tape_num > 0 {
                
                self.no_replyNum.alpha = 1
                self.no_replyNum.text = String(self.tape_num)

            }else{
                
                self.no_replyNum.alpha = 0
            }
            
        }else{
            
            let addBtn = self.setNaviRightBtnWithTitle(title: "添加")
            
            addBtn.addTarget(self, action: #selector(addBtnClicked), for: UIControlEvents.touchUpInside)
            
            if self.tape_num > 0 {
                
                self.Already_replyNum.alpha = 1
                self.Already_replyNum.text = String(self.tape_num)
                
            }else{
                
                self.Already_replyNum.alpha = 0
            }
            
        }
        
    }
    //MARK:小纸条脚标
    func gettape_num() {
     
        let process=CommServer()
        
        let parameters:[String:String] = ["method":"tape_num",
                                          "user_id":myModel.user_id]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            self.tape_num = Int(backMsg.object(forKey: "state") as! String)!
            
            self.setTape_num()
            
            self.tableView.reloadData()
        }
        
    }
    
    func getData()  {
        
        SVProgressHUD.show()
        
        let process=CommServer()

        let parameters:[String:String] = ["method":"tape_list",
                                          "user_id":myModel.user_id,
                                          "unreply":unreply]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state")
            
            self.no_replyArr.removeAllObjects()
            self.Already_replyArr.removeAllObjects()
            
            if (state as! NSString).intValue == 0 {
                
                
            }else{
                
                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                for attributes in array {
                    
                    let entity = small_piece_paperEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)

                    if self.unreply == "0"{
                        self.no_replyArr.add(entity)
                    }else if self.unreply == "1"{
                        self.Already_replyArr.add(entity)
                    }else{
                        
                    }
                    
                }

                
            }
            
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }

    }
    
    func doTape_read(tape_id:String) {
        
        let process=CommServer()
        
        let parameters:[String:String] = ["method":"tape_read",
                                          "user_id":myModel.user_id,
                                          "tape_id":tape_id]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: BUSINESS_LIST_REFRESH_NOTIFY), object: nil)
            
        }

    }
    
    func subVCBackNeedRefresh() {
        
        //刷新数据
        self.getData()
        
        self.gettape_num()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: 实体类
class small_piece_paperEntity: NSObject {
    
    var tape_id:String?
    var isnew:String?
    var create_time:String?
   
    var title:String?
    var content:String?
    var img_name:String?
    var reply_content:String?
    var end_time:String?
    var create_name:String?
    var user_name:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.tape_id = backMsg.object(forKey: "tape_id") as? String
        self.isnew = backMsg.object(forKey: "isnew") as? String
        self.create_time = backMsg.object(forKey: "create_time") as? String
        
        self.title = backMsg.object(forKey: "title") as? String
        self.content = backMsg.object(forKey: "content") as? String
        self.img_name = backMsg.object(forKey: "img_name") as? String
    
        self.user_name = backMsg.object(forKey: "user_name") as? String
        self.reply_content = backMsg.object(forKey: "reply_content") as? String
        self.end_time = backMsg.object(forKey: "end_time") as? String
        self.create_name = backMsg.object(forKey: "create_name") as? String
    }
    
}

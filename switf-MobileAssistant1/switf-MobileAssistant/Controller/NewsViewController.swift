//
//  NewsViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/16.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var system_news_Btn: UIButton!
    @IBOutlet weak var company_news_Btn: UIButton!
    
    let lineLabel = UILabel()
    
    let userDefaults = UserDefaults()
    var myModel:UserEntity!
    
    var arrayCutomer:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "公告"
        
        //自定义对象读取
        let myModelData = userDefaults.data(forKey: "user_message")
        myModel = NSKeyedUnarchiver.unarchiveObject(with: myModelData!) as! UserEntity
        
        lineLabel.frame = CGRect(x: 0, y: system_news_Btn.frame.size.height + 1, width: kScreenW/2, height: 1)
        
        lineLabel.backgroundColor = Maco().RGBA(r: 66, g: 187, b: 222, a: 1)
        
        self.view.addSubview(lineLabel)
        
        self.getData(type_id: "0")
        
        let cellNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        
        tableView .register(cellNib, forCellReuseIdentifier: "NewsTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayCutomer.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell:NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        
        cell.bgView.layer.borderColor = Maco().RGBA(r: 225, g: 225, b: 255, a: 1).cgColor
        cell.bgView.layer.cornerRadius = 5
        cell.bgView.layer.borderWidth = 1
        
        let entity = self.arrayCutomer.object(at: indexPath.row) as! NewsEntity

        
        if entity.type == "0"{
         
            cell.Icon_State.image = UIImage(named: "系统")
        }else if entity.type == "1"{
            
            cell.Icon_State.image = UIImage(named: "通知")
        }else{
            
        }
        
        cell.titleLabel.text = entity.title
        cell.TimeLabel.text = entity.time
        cell.countLabel.text = entity.count

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let entity = self.arrayCutomer.object(at: indexPath.row) as! NewsEntity
        
        let vc = WebViewController()
        
        vc.newsId = entity.notice_id!
        
        vc.titleName = "公告详情"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getData(type_id:String) {
        let process=CommServer()

        
        let parameters:[String:String] =
            ["method":"newsList",
             "dep_id":myModel.dep_id,
             "type_id":type_id,
             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber

            self.arrayCutomer.removeAllObjects()
            
            if state == 0{
                
                
            }else{
                
                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                for attributes in array {
                    
                    let entity = NewsEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    
                    self.arrayCutomer.add(entity)
                    
                }

            }
            
            self.tableView.reloadData()
            
        }
        
        
    }

    @IBAction func change_State_Btn(_ sender: UIButton) {
        
        if sender.tag == 0{
            
            self.getData(type_id: "0")
            
            UIView.animate(withDuration: 0.3, animations: { 
                
                self.system_news_Btn.setTitleColor(Maco().RGBA(r: 66, g: 187, b: 233, a: 1), for: UIControlState.normal)
                self.company_news_Btn.setTitleColor(Maco().RGBA(r: 128, g: 128, b: 128, a: 1), for: UIControlState.normal)
                self.lineLabel.frame = CGRect(x: 0, y: self.system_news_Btn.frame.size.height, width: kScreenW/2, height: 1)
            
            })
            
        }else if sender.tag == 1{
            
            self.getData(type_id: "1")

            UIView.animate(withDuration: 0.3, animations: {
                
                self.system_news_Btn.setTitleColor(Maco().RGBA(r: 128, g: 128, b: 128, a: 1), for: UIControlState.normal)
                self.company_news_Btn.setTitleColor(Maco().RGBA(r: 66, g: 187, b: 233, a: 1), for: UIControlState.normal)

                self.lineLabel.frame = CGRect(x: kScreenW/2, y: self.system_news_Btn.frame.size.height, width: kScreenW/2, height: 1)
                
            })
            
        }else{
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

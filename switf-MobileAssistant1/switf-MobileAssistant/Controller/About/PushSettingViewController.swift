//
//  PushSettingViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/25.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class PushSettingViewController: ZXYBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "推送时间设置"
        
        let RightBtn:UIButton = self.setNaviRightBtnWithTitle(title: "提交")
        
        RightBtn.addTarget(self, action: #selector(submitBtnClicked), for: UIControlEvents.touchUpInside)
        
        let cellNib1 = UINib(nibName: "PushSettingTableViewCell", bundle: nil)
        
        tableView .register(cellNib1, forCellReuseIdentifier: "PushSettingTableViewCell")
        
        let cellNib2 = UINib(nibName: "SwitchTableViewCell", bundle: nil)
        
        tableView .register(cellNib2, forCellReuseIdentifier: "SwitchTableViewCell")
        
        
    }

    func submitBtnClicked()  {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell1:PushSettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PushSettingTableViewCell", for: indexPath) as! PushSettingTableViewCell
        
        let cell2:SwitchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SwitchTableViewCell", for: indexPath) as! SwitchTableViewCell
        
        
        return cell1

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

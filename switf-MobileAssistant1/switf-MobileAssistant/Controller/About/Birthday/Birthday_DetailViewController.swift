//
//  Birthday_DetailViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/12.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Birthday_DetailViewController: ZXYBaseViewController {

    var birthday_id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: BUSINESS_LIST_REFRESH_NOTIFY), object: nil)
    }

    func getData()  {
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

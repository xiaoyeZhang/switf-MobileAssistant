//
//  This_month_unvisitEntity.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/25.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class This_month_unvisitEntity: NSObject {

    var name:String?
    var num:String?
    var company_level:String?
    var address:String?
    var last_time:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.name = backMsg.object(forKey: "name") as? String
        self.num = backMsg.object(forKey: "num") as? String
        self.company_level = backMsg.object(forKey: "address") as? String
        self.address = backMsg.object(forKey: "company_level") as? String
        self.last_time = backMsg.object(forKey: "last_time") as? String
        
    }
    
}

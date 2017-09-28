//
//  CompEntity.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/23.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class CompEntity: NSObject {
    
    var company_id:String?
    var company_level:String?
    var name:String?
    var tel:String?
    var num:String?
    var type:String?
    var scope:String?
    var contact:String?
    var key_name:String?
    var key_tel:String?
    var address:String?
    var update_time:String?
    var company_status:String?
    var is_fist_UserNum:String?
    var user_id:String?
    var user_name:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.company_level = backMsg.object(forKey: "company_level") as? String
        self.num = backMsg.object(forKey: "num") as? String
        self.company_status = backMsg.object(forKey: "company_status") as? String
        self.name = backMsg.object(forKey: "name") as? String
        self.address = backMsg.object(forKey: "address") as? String
    }
}

//
//  NewsEntity.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/14.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class NewsEntity: NSObject {

    var state:String?
    var title:String?
    var content:String?
    var time:String?
    var notice_id:String?
    var type:String?

    var create_id:String?
    var start_time:String?
    var count:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.state = backMsg.object(forKey: "state") as? String
        self.title = backMsg.object(forKey: "title") as? String
        self.content = backMsg.object(forKey: "content") as? String
        self.time = backMsg.object(forKey: "time") as? String
        self.notice_id = backMsg.object(forKey: "notice_id") as? String
        self.type = backMsg.object(forKey: "type") as? String
        self.create_id = backMsg.object(forKey: "create_id") as? String
        self.start_time = backMsg.object(forKey: "start_time") as? String
        self.count = backMsg.object(forKey: "count") as? String
    }
}

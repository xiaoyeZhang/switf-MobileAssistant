
//
//  UserEntity.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 16/9/26.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

class UserEntity: NSObject, NSCoding {

    var push_date:String
    var user_id:String
    var tel:String
    var name:String
    
    var push_disable:String
    var push_sms:String
    var type_id:String
    var deleted:String
    
    var pass_flag:String
    var uuid:String
    var push_flag:String
    
    var push_starttime:String
    var version:String
    var is_first:String
    var job:AnyObject
    
    var point:String
    var num:String
    var dep_name:String
    var push_endtime:String
    
    var password:String
    var area_id:String
    var dep_id:String
    //构造方法
    required init(content : [String : AnyObject]) {
                
        self.name           = content["name"] as! String
        self.tel            = content["tel"] as! String
        
        self.push_date      = content["push_date"] as! String
        self.user_id        = content["user_id"] as! String
        self.push_disable   = content["push_disable"] as! String
        self.push_sms       = content["push_sms"] as! String
        self.type_id        = content["type_id"] as! String
        self.deleted        = content["deleted"] as! String

        self.pass_flag      = content["pass_flag"] as! String
        self.uuid           = content["uuid"] as! String
        
        self.push_flag      = content["push_flag"] as! String
        
        self.push_starttime = content["push_starttime"] as! String
        self.version        = content["version"] as! String
        
        self.is_first       = content["is_first"] as! String
        
        self.job            = content["job"] as AnyObject
        
        self.point          = content["point"] as! String
        self.num            = content["num"] as! String
        
        self.dep_name       = content["dep_name"] as! String
        self.push_endtime   = content["push_endtime"] as! String

        self.password       = content["password"] as! String
        self.area_id        = content["area_id"] as! String
        
        self.dep_id         = content["dep_id"] as! String
    }
    
    //从object解析回来
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.tel = decoder.decodeObject(forKey: "tel") as? String ?? ""
        self.push_date = decoder.decodeObject(forKey: "push_date") as? String ?? ""
        self.user_id = decoder.decodeObject(forKey: "user_id") as? String ?? ""
        
        self.push_disable = decoder.decodeObject(forKey: "push_disable") as? String ?? ""
        self.push_sms = decoder.decodeObject(forKey: "push_sms") as? String ?? ""
        self.type_id = decoder.decodeObject(forKey: "type_id") as? String ?? ""
        self.deleted = decoder.decodeObject(forKey: "deleted") as? String ?? ""
        
        self.pass_flag = decoder.decodeObject(forKey: "pass_flag") as? String ?? ""
        self.uuid = decoder.decodeObject(forKey: "uuid") as? String ?? ""
        self.push_flag = decoder.decodeObject(forKey: "push_flag") as? String ?? ""
        
        self.push_starttime = decoder.decodeObject(forKey: "push_starttime") as? String ?? ""
        self.version = decoder.decodeObject(forKey: "version") as? String ?? ""
        self.is_first = decoder.decodeObject(forKey: "is_first") as? String ?? ""
        self.job = decoder.decodeObject(forKey: "job") as? String as AnyObject 
        
        self.point = decoder.decodeObject(forKey: "point") as? String ?? ""
        self.num = decoder.decodeObject(forKey: "num") as? String ?? ""
        self.dep_name = decoder.decodeObject(forKey: "dep_name") as? String ?? ""
        self.push_endtime = decoder.decodeObject(forKey: "push_endtime") as? String ?? ""
        
        self.password = decoder.decodeObject(forKey: "password") as? String ?? ""
        self.area_id = decoder.decodeObject(forKey: "area_id") as? String ?? ""
        self.dep_id = decoder.decodeObject(forKey: "dep_id") as? String ?? ""
        
        
    }
    
    //编码成object
    func encode(with coder: NSCoder) {
        coder.encode(push_date, forKey:"push_date")
        coder.encode(user_id, forKey:"user_id")
        coder.encode(name, forKey:"name")
        coder.encode(tel, forKey:"tel")
        
        coder.encode(push_disable, forKey:"push_disable")
        coder.encode(push_sms, forKey:"push_sms")
        coder.encode(type_id, forKey:"type_id")
        coder.encode(deleted, forKey:"deleted")
        
        coder.encode(pass_flag, forKey:"pass_flag")
        coder.encode(uuid, forKey:"uuid")
        coder.encode(push_flag, forKey:"push_flag")
        
        coder.encode(push_starttime, forKey:"push_starttime")
        coder.encode(version, forKey:"version")
        coder.encode(is_first, forKey:"is_first")
        coder.encode(job, forKey:"job")
        
        coder.encode(point, forKey:point)
        coder.encode(num, forKey:"num")
        coder.encode(dep_name, forKey:"dep_name")
        coder.encode(push_endtime, forKey:"push_endtime")
        
        
        coder.encode(password, forKey:"password")
        coder.encode(area_id, forKey:"area_id")
        coder.encode(dep_id, forKey:"dep_id")
        
    }
    
}

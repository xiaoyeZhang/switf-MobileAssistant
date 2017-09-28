//
//  CommServer.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 16/9/22.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit
import Alamofire
class CommServer: NSObject {

    //定义block回调 -- 不带返回值
    typealias fucBlock = (_ backMsg : NSDictionary) ->()
    
    //定义block回调 -- 带返回值
    typealias BackfucBlock = (_ backMsg :NSDictionary) ->(Bool)
    
    
    func LoginprocessWithBlock( cmdStr: [String:String],blockProperty:@escaping fucBlock){
        
//        var cmdStr = cmdStr
        
//        cmdStr.updateValue("One 新的值", forKey: "")

//        let cmdStr = cmdStr as! NSMutableDictionary
        
//        cmdStr.setValue("ddd", forKey: "rere")
        
        Alamofire.request(BASEURL,parameters: cmdStr
            ).responseJSON { response in
                
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            switch response.result{
                    
                case.success:
                    if let JSON = response.result.value as? NSDictionary {
                        

                        if (JSON.object(forKey: "content") != nil){
                            
                            let content: NSDictionary = JSON.object(forKey: "content") as! NSDictionary

                            let userDefaults = UserDefaults()
                            
                            //自定义对象存储
                            let model = UserEntity(content:content as! [String : AnyObject])
                            //实例对象转换成Data
                            let modelData = NSKeyedArchiver.archivedData(withRootObject: model)
                            //存储Data对象
                            userDefaults.set(modelData, forKey: "user_message")
                        }

                        blockProperty(JSON)
                    }
                
                case.failure(let err):
                    
                    print(err)
                }
        }

    
    }
    
    func processWithBlock( cmdStr: [String:String],blockProperty:@escaping fucBlock){
        
        //        var cmdStr = cmdStr
        
        //        cmdStr.updateValue("One 新的值", forKey: "")
        
        //        let cmdStr = cmdStr as! NSMutableDictionary
        
        //        cmdStr.setValue("ddd", forKey: "rere")
        
        Alamofire.request(BASEURL,parameters: cmdStr
            ).responseJSON { response in

                switch response.result{
                    
                case.success:
                    if let JSON = response.result.value as? NSDictionary {
                        
                        blockProperty(JSON)
                    }
                    
                case.failure(let err):
                    
                    print(err)
                }
        }
        
        
    }
    
    
//    func ProcessWithBlock(cmdStr : NSDictionary ,blockProperty:@escaping fucBlock) -> (Bool) {
//        
//        var JSON = NSDictionary()
//        
//        Alamofire.request(BASEURL,parameters: cmdStr as? Parameters
//            ).responseJSON { response in
//                
//                JSON = response.result.value as! NSDictionary
//                    
//                let userDefaults = UserDefaults()
//                
//                userDefaults.setValue((JSON.object(forKey: "content") as! NSDictionary).object(forKey: "user_id"), forKey: "user_id")
//                userDefaults.synchronize()
//                
//                print(userDefaults.object(forKey: "user_id"))
//              
//                blockProperty(JSON)
//                
//                return
//        }
//        
//        return true
//    }
}

//
//  Maco.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/21.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

//boss服务器
//let BASEURL = "http://gzcmm.dayo.net.cn/cmm/cmm_boss_token.php"
//let TERMINAL_PHOTO_URL = "http://gzcmm.dayo.net.cn/cmm/terminal_photo/"
//let NEWS_URL = "http://gzcmm.dayo.net.cn/cmm/note_app.php"

//测试服务器
let BASEURL = "http://120.24.63.90/gzcms/cmm_boss.php"
let TERMINAL_PHOTO_URL = "http://120.24.63.90/gzcms/terminal_photo/"
let NEWS_URL = "http://120.24.63.90/gzcms/note_app.php"

//当前系统版本
let kVersion = (UIDevice.current.systemVersion as NSString).floatValue
//APP版本
let ClientVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String

let APPClientVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

//      屏幕宽度
let kScreenW = UIScreen.main.bounds.width
//屏幕高度
let kScreenH = UIScreen.main.bounds.height


// 角色
let ROLE_TWO = "2" //二级经理
let ROLE_THREE = "1" //三级经理
let ROLE_CUSTOMER = "0" //客户经理
let ROLE_SPECIAL = "3" //综合支撑部(特号)
let ROLE_VISIT = "4"    //综合支撑部(预约拜访)
let ROLE_TERMINAL = "5" //综合支撑部(终端办理)
let ROLE_RETREAT = "6" //综合支撑部(终端退库)
let ROLE_REPAIR = "7" //售后维修单
let ROLE_BOOK = "8" //缴费台账登记
let ROLE_CARD = "9" //办卡
let ROLE_BILL = "10" //开具发票
let ROLE_CARD_1 = "11" //办卡(特号)
let ROLE_LIBRARY_1 = "12" ///** 串号已发送到客户经理（终端出库） */
let ROLE_LIBRARY_2 = "13" ///** 是否完成营销活动受理（终端出库） */
let ROLE_LIBRARY_3 = "14" ///** 完成出库（终端出库） */
let ROLE_COMMON = "25" //通用营销人员
let ROLE_PRODUCT = "26" //产品经理
let ROLE_SOCOALCHANNEL = "30" //社会渠道

class Maco: NSObject {


    //MARK: -颜色方法
    func RGBA (r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat)-> UIColor{
        return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    func setLevel(company_level: NSString) -> String {
        
        var level:String = ""
        
        switch (company_level.intValue) {
        case 0:
            level = "A+类客户"
            break;
        case 1:
            level = "A1类客户"
            break;
        case 2:
            level = "B1类客户"
            break;
        case 3:
            level = "A2类客户"
            break;
        case 4:
            level = "B2类客户"
            break;
        case 5:
            level = "C1类客户"
            break;
        case 6:
            level = "C2类客户"
            break;
        case 7:
            level = "D类客户"
            break;
        case 99:
            level = "未定级别"
            break;
        default:
            break;
        }
        
        return level
    }
    
}

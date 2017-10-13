//
//  XYStartEndDatePicker.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/10.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

let instance: XYStartEndDatePicker = XYStartEndDatePicker()

class XYStartEndDatePicker: UIView {

    let bgView = UIView()
    let control = UIControl()
    
//    - (instancetype)initWithFrame:(CGRect)frame
    
    func  initWithFrame(frame:CGRect) -> XYStartEndDatePicker {
        
        
//        if self {
        
       
            bgView.frame = CGRect(x: 0, y: kScreenH - 398, width: kScreenW, height: 398)
//            bgView.autoresizingMask = UIViewAutoresizing.flexibleWidth|UIViewAutoresizing.flexibleTopMargin
            bgView.backgroundColor = UIColor.white
            self.addSubview(bgView)
            
            
//        }
        
        return instance
    }

}


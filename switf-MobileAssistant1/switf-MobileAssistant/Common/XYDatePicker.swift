//
//  XYDatePicker.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/25.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

protocol XYDatePickerDelegate: class {
    
    func datePickerDonePressed(datePicker:XYDatePicker)
    func datePickerCancelPressed(datePicker:XYDatePicker)
}

class XYDatePicker: UIView {

    let bgView = UIView()
    let control = UIControl()
    var datePicker = UIDatePicker()
    var delegate:XYDatePickerDelegate?
    
    var date:Date!
    
    func initWithFrame(frame:CGRect) {
        
        self.frame = frame
        self.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]

        control.frame = self.bounds
        control.backgroundColor = UIColor.black
        control.alpha = 0
        control.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        control.addTarget(self, action: #selector(cancelBtnClickd), for: UIControlEvents.touchUpInside)
        self.addSubview(control)
        
        bgView.frame = CGRect(x: 0, y: kScreenH - 206, width: kScreenW, height: 206)
        bgView.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleTopMargin]
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 44))
        toolbar.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleTopMargin]
        
        let cancelItem = UIBarButtonItem.init(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnClickd))
        let doneItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneBtnClicked))
        let flexibleSpaceItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [cancelItem,flexibleSpaceItem,doneItem]
        
        bgView.addSubview(toolbar)
        
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: 44, width: kScreenW, height: 160))
        datePicker.datePickerMode = .date
        datePicker.autoresizingMask = [.flexibleTopMargin,.flexibleWidth]
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN") as Locale
        bgView.addSubview(datePicker)

    }

    func cancelBtnClickd()  {
        
        self.date = nil
        
        if((delegate) != nil){
            delegate?.datePickerCancelPressed(datePicker: self)
        }
        
        self.dismiss()
    }
    
    func doneBtnClicked() {
        
        self.date = datePicker.date
        
        if((delegate) != nil){
            delegate?.datePickerDonePressed(datePicker: self)
        }
        self.dismiss()

    }
    
    func dismiss() {
 
        var rect = bgView.frame
        
        rect.origin.y += rect.size.height
    
        UIView.animate(withDuration: 0.3, animations: { 
            self.control.alpha = 0
            self.bgView.frame = rect
        
        }) { (finished) in
    
            self.removeFromSuperview()
        }
        
    }
    func show() {
        
        UIApplication.shared.keyWindow?.addSubview(self)
        
        var rect = bgView.frame
        
        rect.origin.y += rect.size.height
        bgView.frame = rect
        
        var showRect = rect
        showRect.origin.y -= showRect.size.height
        
        UIView.animate(withDuration: 0.3) { 
            self.control.alpha = 0.5
            self.bgView.frame = showRect
        }
    }
    
    
}

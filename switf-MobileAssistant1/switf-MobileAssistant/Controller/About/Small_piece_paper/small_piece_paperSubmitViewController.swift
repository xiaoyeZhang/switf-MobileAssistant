//
//  small_piece_paperSubmitViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/24.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class small_piece_paperSubmitViewController: ZXYBaseViewController,UITextViewDelegate,UITextFieldDelegate,AddPhotoViewControllerDelegate {

    @IBOutlet weak var titleTextFile: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var user_nameTextFile: UITextField!
    @IBOutlet weak var end_timeTextFile: UITextField!
    
    var uploadImagesArr:NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "派发小纸条"
        
        self.textView.layer.borderWidth = 1
        self.textView.layer.cornerRadius = 3
        self.textView.layer.borderColor = Maco().RGBA(r: 221, g: 221, b: 221, a: 1).cgColor
        
        let addBtn = self.setNaviRightBtnWithTitle(title: "派发")
        
        addBtn.addTarget(self, action: #selector(addBtnClicked), for: UIControlEvents.touchUpInside)
        
        self.imageBtn.addTarget(self, action: #selector(updownImage), for: UIControlEvents.touchUpInside)
    }

    func addBtnClicked() {
        
        
    }
    
    func updownImage() {
        
        let vc = P_AddPhotoViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func addPhotoViewController(imagesArr: NSArray) {
        
        self.uploadImagesArr = imagesArr
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
            
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.user_nameTextFile {
            
            self.user_nameTextFile.resignFirstResponder()
            
            let vc = No_visit_listViewController()
            
//            vc.tcVC = self;
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if textField == self.end_timeTextFile {
            
//            self.changeDate()
            
        }

        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func changeDate() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

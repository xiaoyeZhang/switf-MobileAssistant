//
//  small_piece_paperSubmitViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/24.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit
import Alamofire
class small_piece_paperSubmitViewController: ZXYBaseViewController,UITextViewDelegate,UITextFieldDelegate,AddPhotoViewControllerDelegate,XYDatePickerDelegate,No_visit_listViewControllerDelegate {

    @IBOutlet weak var titleTextFile: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var user_nameTextFile: UITextField!
    @IBOutlet weak var end_timeTextFile: UITextField!
    var cusName = ""
    var cus_id = ""

    var uploadImagesArr:NSMutableArray = []
    
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
        
        if !isDone{
            return
        }
        
        isDone = false
        
        
        if self.titleTextFile.text?.characters.count == 0 {
            self.ShowAlertCon(title: "警告", message: "主题不能为空！", cancelTitle: "确定", popC: "0")

            isDone = true
            return
        }
        
        if self.textView.text?.characters.count == 0 {
            
            self.ShowAlertCon(title: "警告", message: "内容不能为空！", cancelTitle: "确定", popC: "0")
            
            isDone = true
            return
        }
        
        if self.user_nameTextFile.text?.characters.count == 0 {

            self.ShowAlertCon(title: "警告", message: "请选择客户经理！", cancelTitle: "确定", popC: "0")
            
            isDone = true
            return
        }

        let process=CommServer()
        
        
        SVProgressHUD.show()
        
        let parameters:[String:String] = ["method":"tape_add",
                                          "end_time":self.end_timeTextFile.text!,
                                          "content":self.textView.text!,
                                          "title":self.titleTextFile.text!,
                                          "user_ids":cus_id,
                                          "create_id":myModel.user_id]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            if state != 0 {
                let tape_id = backMsg.object(forKey: "content")

                if self.uploadImagesArr.count != 0{
                    
                    self.uploadImagesWithIndex(index: 0, tape_id: tape_id as! String)

                }else{
                    SVProgressHUD.dismiss()
                    self.ShowAlertCon(title: "提示", message: "提交成功", cancelTitle: "确定", popC: "0")
                }
                
            }

            self.isDone = true

        }
    }
    
    func uploadImagesWithIndex(index:Int,tape_id:String){
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //采用post表单上传
                // 参数解释：
                //withName:和后台服务器的name要一致 ；fileName:可以充分利用写成用户的id，但是格式要写对； mimeType：规定的，要上传其他格式可以自行百度查一下
//                multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //如果需要上传多个文件,就多添加几个
                //multipartFormData.append(imageData, withName: "file", fileName: "123456.jpg", mimeType: "image/jpeg")
                //......
                
            let method = "common_upload"
            let upload_type = "tape"
                
                
            multipartFormData.append(method.data(using: String.Encoding.utf8)!, withName: "method")
            multipartFormData.append(tape_id.data(using: String.Encoding.utf8)!, withName: "tape_id")
            multipartFormData.append(upload_type.data(using: String.Encoding.utf8)!, withName: "upload_type")
                
            let imageName = UUID().uuidString + ".jpg"
                
            let data = UIImageJPEGRepresentation(self.uploadImagesArr[index] as! UIImage, 0.5)
            
            multipartFormData.append(imageName.data(using: String.Encoding.utf8)!, withName: "picname")
            multipartFormData.append(data!, withName: "file", fileName:imageName, mimeType: "image/png")
                
        },to: BASEURL,encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    guard let result = response.result.value else { return }
                    print("json:\(result)")  //  result: state = 1;
                    let resule:NSDictionary = result as! NSDictionary
                    print("\(String(describing: resule["state"]))")
                    if resule["state"] as! NSNumber == 1{

                        if index < self.uploadImagesArr.count - 1{
                            self.uploadImagesWithIndex(index: index+1, tape_id: tape_id)
                        }else{
                            
                            SVProgressHUD.dismiss()
                            
                            self.ShowAlertCon(title: "提示", message: "提交成功", cancelTitle: "确定", popC: "1")
                        }

                    }else{
                        self.ShowAlertCon(title: "提示", message: "图片上传失败", cancelTitle: "确定", popC: "1")
                    }
                    
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
            case .failure(let encodingError):
                //打印连接失败原因
                print(encodingError)
            }
        })
    }
    
    func updownImage() {
        
        let vc = P_AddPhotoViewController()
        vc.imagesMuArr = self.uploadImagesArr
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func addPhotoViewController(imagesArr: NSMutableArray) {
        
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
            
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)

            return false

        }else if textField == self.end_timeTextFile {
            
            self.changeDate()

            return false

        }else{
            
            return true

        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func changeDate() {

        self.end_timeTextFile.resignFirstResponder()

        let datePicker = XYDatePicker()
        datePicker.initWithFrame(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH))
        datePicker.delegate = self
        datePicker.datePicker.datePickerMode = .date

        if (self.end_timeTextFile.text?.characters.count)! > 0{
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            datePicker.date = dateFormatter.date(from: self.end_timeTextFile.text!)
            
        }
        
        datePicker.show()
        
    }
    
    func setCustomer(ex: NSMutableArray) {
        
        cusName = ""
        cus_id = ""
        for i in 0 ..< ex.count  {
            
            let entity:No_visit_listEntity = ex.object(at: i) as! No_visit_listEntity
            
            cusName = cusName + ";" + entity.name!
            cus_id = cus_id + ";" + entity.user_id!
        }

        self.user_nameTextFile.text = cusName.substring(from: cusName.index(cusName.startIndex, offsetBy: 1))
    }
    
    func datePickerDonePressed(datePicker: XYDatePicker) {
    
        let dateFormatter = DateFormatter()
        
        dateFormatter.setLocalizedDateFormatFromTemplate("zh_CN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateStr = dateFormatter.string(from: datePicker.date)
        
        self.end_timeTextFile.text = dateStr
    }
    
    func datePickerCancelPressed(datePicker: XYDatePicker) {
        
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

//
//  P_AddPhotoViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/24.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

protocol AddPhotoViewControllerDelegate: class {
    
    func addPhotoViewController(imagesArr:NSMutableArray)
    
}

class P_AddPhotoViewController: ZXYBaseViewController,UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagesMuArr:NSMutableArray = []
    let VC_Type = ""
    var delegate:AddPhotoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "上传资料"
        let addBtn = self.setNaviRightBtnWithTitle(title: "提交")
        
        addBtn.addTarget(self, action: #selector(submitBtnClicked), for: UIControlEvents.touchUpInside)

        let cellNib = UINib(nibName: "PhotosCollectionViewCell", bundle: nil)
        
        collectionView.register(cellNib, forCellWithReuseIdentifier: "PhotosCollectionViewCell")

        
    }
    
    func submitBtnClicked() {
        
        if VC_Type == "订单需求发起" || VC_Type == "新订单需求发起"{
            
        }else{
            if imagesMuArr.count == 0{
                self.ShowAlertCon(title: "警告", message: "请上传合同资料", cancelTitle: "确定", popC: "0")
            }
        }
        
        //调用代理方法
        if((delegate) != nil)
        {
            for i in 0 ..< imagesMuArr.count {
                if imagesMuArr[i] is UIImage{
                    
                }else{
                    var imageUrl:String = ""
                    
                    if (imagesMuArr[i] as! String).range(of: ".") != nil {
                        
                        imageUrl = String(format: "%@%@", TERMINAL_PHOTO_URL,imagesMuArr[i] as! CVarArg)
                    }else{
                        imageUrl = String(format: "%@%@.jpg", TERMINAL_PHOTO_URL,imagesMuArr[i] as! CVarArg)
                    }
                    
                    let image = UIImageView()
                    
                    if let url = URL(string: imageUrl) {
                        
                        image.downloadedFrom(url: url)
                        
                    }
                    imagesMuArr.replaceObject(at: i, with: image.image!)
                }
            }
            delegate?.addPhotoViewController(imagesArr: imagesMuArr)
        }

        self.navigationController?.popViewController(animated: true)

    }
    
    func deleteBtnClicked(sender:UIButton) {

        imagesMuArr.removeObject(at: sender.tag)
        self.collectionView.reloadData()
    }
    
    //MARK: - 拍照
    @IBAction func takePhotoBtnClicked(_ sender: UIButton) {
    
        let sourceType = UIImagePickerControllerSourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
        
        
    }
    
    //MARK: - 选择图片
    @IBAction func getPhotoFromLibrary(_ sender: UIButton) {
        
        let sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
            
        }

        
    }
    
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker:UIImagePickerController, didFinishPickingMediaWithInfo info: [String :Any]){
        
        let type:String = (info[UIImagePickerControllerMediaType]as!String)
        //当选择的类型是图片
        if type=="public.image"
        {
            let image = info[UIImagePickerControllerOriginalImage]as!UIImage
            
            imagesMuArr.add(image)

            picker.dismiss(animated:true, completion:nil)
        }
        
        self.collectionView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker:UIImagePickerController){
        picker.dismiss(animated:true, completion:nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesMuArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.size.width - 30)/2, height: (collectionView.bounds.size.width - 30)/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:PhotosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        
        cell.imageView.contentMode = .scaleAspectFill
        
        cell.deleteBtn.tag = indexPath.row
        
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClicked), for: UIControlEvents.touchUpInside)
        
        let image = imagesMuArr[indexPath.row]
        
        if image is UIImage {
            
            cell.imageView.image = image as? UIImage
            
        }else if image is String{
            
            
            var imageUrl:String = ""
            
            if (image as! String).range(of: ".") != nil {
            
                imageUrl = String(format: "%@%@", TERMINAL_PHOTO_URL,image as! CVarArg)
            }else{
                imageUrl = String(format: "%@%@.jpg", TERMINAL_PHOTO_URL,image as! CVarArg)
            }

            
            if let url = URL(string: imageUrl) {
                
                 cell.imageView.downloadedFrom(url: url)
                
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
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

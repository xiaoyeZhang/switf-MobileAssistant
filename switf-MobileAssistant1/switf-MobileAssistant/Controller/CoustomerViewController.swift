//
//  CoustomerViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/16.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class CoustomerViewController: UIViewController ,UICollectionViewDelegate ,UICollectionViewDataSource{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var ListArr:NSMutableArray = []
    
    var myModel:UserEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "客户"
        
        //自定义对象读取
        let myModelData = UserDefaults().data(forKey: "user_message")
        myModel = NSKeyedUnarchiver.unarchiveObject(with: myModelData!) as! UserEntity
        
        ListArr.add(["name":"我的集团","image":"bm_vnetwork","viewController":"MyGroupViewController"])
    
        if (myModel.type_id as NSString).isEqual(to: "0") {
            
            ListArr.add(["name":"添加联系人","image":"bm_addclient","viewController":"ContactAddViewController"])
        }

        let cellNib = UINib(nibName: "BusinessListCollectionViewCell", bundle: nil)
        collectionView!.register(cellNib, forCellWithReuseIdentifier: "BusinessListCollectionViewCell");
        
    }

//    //分区数
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 3;
//    }
    
    //每个分区含有的 item 个数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.size.width - 4)/3, height: (collectionView.bounds.size.height-4*4-135)/3)
    }
    
    //返回 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessListCollectionViewCell", for: indexPath) as! BusinessListCollectionViewCell
        
        let dic:[String:String] =  ListArr.object(at: indexPath.row) as! [String:String]
        
        cell.backgroundColor = UIColor.white
        cell.iconImageView.image = UIImage(named: dic["image"]!)
        cell.titleLable.text = dic["name"]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dic:[String:String] =  ListArr.object(at: indexPath.row) as! [String:String]
        
        let targetVC:String = dic["viewController"]!
        
        var NameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"]as? String
        
        NameSpace = NameSpace?.replacingOccurrences(of: "-", with: "_")
        
        let clsName = NameSpace! + "." + targetVC
        
        let model = NSClassFromString(clsName) as! UIViewController.Type

        let vc = model.init()
        
        self.navigationController?.pushViewController(vc, animated: true)
            
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

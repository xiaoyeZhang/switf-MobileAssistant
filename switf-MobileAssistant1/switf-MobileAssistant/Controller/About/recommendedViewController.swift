//
//  recommendedViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/10.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class recommendedViewController: ZXYBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayCutomer:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "APP应用推荐"
        
        let cellNib = UINib(nibName: "BusinessListCollectionViewCell", bundle: nil)
        
        collectionView.register(cellNib, forCellWithReuseIdentifier: "BusinessListCollectionViewCell")
        
        self.getData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayCutomer.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.size.width - 20)/3, height: (collectionView.bounds.size.width - 20)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:BusinessListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessListCollectionViewCell", for: indexPath) as! BusinessListCollectionViewCell
        
        let entity:recommendedEntity =  arrayCutomer.object(at: indexPath.row) as! recommendedEntity
        
        cell.titleLable.text = entity.name
        
        let urlString = entity.icon
        if let url = URL(string: urlString!) {
            cell.iconImageView.downloadedFrom(url: url)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let entity:recommendedEntity =  arrayCutomer.object(at: indexPath.row) as! recommendedEntity

        let vc = Reommended_DetailViewController()
        
        vc.APP_Name = entity.name!
        vc.APP_ID = entity.app_id!
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getData() {
        
        SVProgressHUD.show()
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"get_app_list",

             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state:NSNumber = backMsg.object(forKey: "state") as! NSNumber
            
            if state == 1{
                
                let array:NSArray = backMsg.object(forKey: "content") as! NSArray
                
                for attributes in array {
                    
                    let entity = recommendedEntity()
                    
                    entity.initWithAttributes(backMsg: attributes as! NSDictionary)
                    
                    self.arrayCutomer.add(entity)
                    
                }
                
            }else{
                
            }
            
            self.collectionView.reloadData()
            
            SVProgressHUD.dismiss()
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

class recommendedEntity: NSObject {
    
    
    var icon:String?
    var app_id:String?
    var name:String?
    
    func initWithAttributes(backMsg :NSDictionary) {
        
        self.name = backMsg.object(forKey: "name") as? String
        self.icon = backMsg.object(forKey: "icon") as? String
        self.app_id = backMsg.object(forKey: "app_id") as? String
        
    }
    
}

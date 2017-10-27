//
//  Centralized_managementViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/27.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class Centralized_managementViewController: ZXYBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var CollectionView: UICollectionView!
    var MainBusinessArr:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "集中化管理"
        
        self.CollectionView.backgroundColor = UIColor.white
        if myModel.type_id == ROLE_CUSTOMER || myModel.type_id == ROLE_PRODUCT{
            
            MainBusinessArr = [["section":"0","list":
                                    [["title":"欠费提醒","icon":"欠费-icon","viewController":"Payment_arrears_listViewController","VCbool":"1"],
                                     ["title":"合同到期提醒","icon":"合同","viewController":"Contract_expiresViewController","VCbool":"1"],
                                     ["title":"客户生日提醒","icon":"生日","viewController":"Birthday_listViewController","VCbool":"1"],
                                     ["title":"长期未拜访","icon":"拜访记录","viewController":"No_visit_baselistViewController","VCbool":"1"]]],
                               ["section":"1","list":
                                    [["title":"资料库","icon":"资料2","viewController":"Product_imformationViewController","VCbool":"1"],
                                     ["title":"祝福短信库","icon":"短信","viewController":"SMS_MessageViewController","VCbool":"1"],
                                     ["title":"案例库","icon":"案例","viewController":"CaseViewController","VCbool":"1"],
                                     ["title":"营销活动信息库","icon":"营销","viewController":"Markeing_classificationViewController","VCbool":"1"]]],
                               ["section":"2","list":
                                    [["title":"在线考试","icon":"在线考试-(1)","viewController":"Examination_SeconViewController","VCbool":"1"],
                                     ["title":"历史试卷","icon":"试卷","viewController":"Exam_historylistViewController","VCbool":"1"],
                                     ["title":"自测","icon":"考试","viewController":"Exam_self_testingViewController","VCbool":"1"],
                                     ["title":"积分排行","icon":"积分","viewController":"Integral_rankingViewController","VCbool":"1"]]]
            ]
        }else{
            MainBusinessArr = [["section":"0","list":
                                    [["title":"欠费提醒","icon":"欠费-icon","viewController":"Payment_arrears_listViewController","VCbool":"1"],
                                     ["title":"合同到期提醒","icon":"合同","viewController":"Contract_expiresViewController","VCbool":"1"],
                                     ["title":"客户生日提醒","icon":"生日","viewController":"Birthday_listViewController","VCbool":"1"],
                                     ["title":"长期未拜访","icon":"拜访记录","viewController":"No_visit_baselistViewController","VCbool":"1"]]],
                               ["section":"1","list":
                                    [["title":"资料库","icon":"资料2","viewController":"Product_imformationViewController","VCbool":"1"],
                                     ["title":"祝福短信库","icon":"短信","viewController":"SMS_MessageViewController","VCbool":"1"],
                                     ["title":"案例库","icon":"案例","viewController":"CaseViewController","VCbool":"1"],
                                     ["title":"营销活动信息库","icon":"营销","viewController":"Markeing_classificationViewController","VCbool":"1"]]],
                               ["section":"2","list":
                                    [["title":"在线考试","icon":"在线考试-(1)","viewController":"Examination_SeconViewController","VCbool":"1"],
                                     ["title":"历史试卷","icon":"试卷","viewController":"Exam_historylistViewController","VCbool":"1"],
                                     ["title":"积分排行","icon":"积分","viewController":"Integral_rankingViewController","VCbool":"1"]]]
            ]
        }
    
        let CollcellNib = UINib(nibName: "Central_manageCollectionViewCell", bundle: nil)
        
        CollectionView.register(CollcellNib, forCellWithReuseIdentifier: "Central_manageCollectionViewCell")
        
        CollectionView!.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "HeaderView");
        
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return MainBusinessArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        for iC in 0 ..< MainBusinessArr.count {
            if section == iC {
                return ((MainBusinessArr.object(at: iC) as! NSDictionary).object(forKey: "list") as! NSArray).count
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.size.width - 10)/4, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: NSInteger) -> CGSize {
        
        return CGSize(width: collectionView.bounds.size.width, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:Central_manageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Central_manageCollectionViewCell", for: indexPath) as! Central_manageCollectionViewCell
        cell.backgroundColor = UIColor.white
        
        let dic:[String:String] =  ((MainBusinessArr.object(at: indexPath.section) as! NSDictionary).object(forKey: "list") as! NSArray).object(at: indexPath.row) as! [String:String]
        
        cell.titleLable.text = dic["title"]
        cell.iconImageView.image = UIImage(named: dic["icon"]!)
        cell.iconImageView.contentMode = UIViewContentMode.scaleAspectFit
        cell.titleLable.font = UIFont.systemFont(ofSize: 12)
        cell.backgroundColor = UIColor.white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var headerView = UICollectionReusableView()
        
        if kind == UICollectionElementKindSectionHeader {
            
            headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath)
            
            headerView.backgroundColor = Maco().RGBA(r: 244, g: 244, b: 244, a: 1)
            
            let titilabel = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 25))
            
            titilabel.font = UIFont.systemFont(ofSize: 13)
            titilabel.textColor = Maco().RGBA(r: 130, g: 130, b: 130, a: 1)
            
            if indexPath.section == 0{
                titilabel.text = "策略集中制定"
            }else if indexPath.section == 1{
                titilabel.text = "政策集中解读"
            }else if indexPath.section == 2{
                titilabel.text = "学习集中管理"
            }else{
                
            }
            headerView.addSubview(titilabel)
            
        }
        
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        let strType = (((MainBusinessArr.object(at: indexPath.section) as! NSDictionary).object(forKey: "list") as! NSArray).object(at: indexPath.row) as! NSDictionary).object(forKey: "VCbool") as! String
        let viewControllerStr = (((MainBusinessArr.object(at: indexPath.section) as! NSDictionary).object(forKey: "list") as! NSArray).object(at: indexPath.row) as! NSDictionary).object(forKey: "viewController") as! String
        
        if strType == "0" {
            
            
        }else{
                
                if viewControllerStr.isEmpty {
                    
                    return
                }
                
//                self.pushViwController(targetVC: viewControllerStr)

        }
        
    }
    
    func pushViwController(targetVC:String) {
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

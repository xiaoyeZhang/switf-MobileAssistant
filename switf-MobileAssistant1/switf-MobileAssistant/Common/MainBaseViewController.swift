//
//  MainBaseViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/18.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class MainBaseViewController: ZXYBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var name = ""
    
    var BusinessArr:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = name
        
        self.initListData()
        
        let cellNib = UINib(nibName: "BusinessListCollectionViewCell", bundle: nil)
        
        collectionView.register(cellNib, forCellWithReuseIdentifier: "BusinessListCollectionViewCell")
        
    }

    func initListData()  {
        
        if name == "走访任务系统"{
            
            if myModel.is_first == "1"{
                BusinessArr.add(["title":"制定走访任务","icon":"制定走访任务","viewController":"Task_Two_CreateViewController"])
            }else{
                 BusinessArr.add(["title":"制定走访任务","icon":"制定走访任务","viewController":"TaskCreateViewController"])
            }
            
            BusinessArr.add(["title":"走访任务列表","icon":"走访任务列表","viewController":"TaskListViewController"])
            
            BusinessArr.add(["title":"长期未拜访","icon":"长期未拜访","viewController":"No_visit_baselistViewController"])
            
            if myModel.type_id == ROLE_CUSTOMER || myModel.type_id == ROLE_TWO || myModel.type_id == ROLE_THREE{
                
                 BusinessArr.add(["title":"实时定位查看","icon":"定位1","viewController":"LocationViewViewController"])
                 BusinessArr.add(["title":"实时信息查看","icon":"查看","viewController":"InformationViewViewController"])
            }
            
            if myModel.type_id == ROLE_TWO || myModel.type_id == ROLE_THREE || myModel.type_id == ROLE_PRODUCT{
                BusinessArr.add(["title":"产品经理走访","icon":"bm_directory","viewController":"Product_VisitListViewController"])
            }
            
        }else if name == "订单中心"{
            
            BusinessArr.add(["title":"业务联系人","icon":"p_special3","viewController":"Business_contacts_ListViewController"])
            
            if myModel.type_id != ROLE_SOCOALCHANNEL {
                
                if myModel.type_id != ROLE_CUSTOMER || myModel.type_id != ROLE_THREE {
                    BusinessArr.add(["title":"订单需求发起","icon":"p_book3","viewController":"CustomerViewController"])
                }
                
                BusinessArr.add(["title":"我的订单","icon":"p_terminal3","viewController":"M_Order_demandViewController"])
                BusinessArr.add(["title":"故障投诉","icon":"p_stock3","viewController":"Trouble_callListViewController"])
                BusinessArr.add(["title":"业务变更","icon":"p_marking","viewController":"Business_change_listViewController"])
            }
            
            if myModel.type_id != ROLE_CUSTOMER {
                
                if myModel.type_id == ROLE_SOCOALCHANNEL {
                    BusinessArr.add(["title":"SA专用发起","icon":"p_book3","viewController":"SA_ListViewController"])
                }
                BusinessArr.add(["title":"我的SA工单","icon":"分合户","viewController":"SA_SpecialViewController"])
            }
            
        }else if name == "其他资料库"{
            
            BusinessArr.add(["title":"祝福短信库","icon":"祝福短信库-1","viewController":"SMS_MessageViewController"])

            BusinessArr.add(["title":"产品资料库","icon":"产品资料库-1","viewController":"Product_imformationViewController"])

            BusinessArr.add(["title":"案例库","icon":"案例库-1","viewController":"CaseViewController"])

            BusinessArr.add(["title":"营销活动信息库","icon":"营销活动方案库-1","viewController":"Markeing_classificationViewController"])

            BusinessArr.add(["title":"营销中心","icon":"产品中心","viewController":"Marketing_CenterListViewController"])

            BusinessArr.add(["title":"集中化管理","icon":"bm_addclient-1","viewController":"Focus_ListViewController"])

            
        }else if name == "考试系统"{
            
            BusinessArr.add(["title":"考试","icon":"考试-(1)","viewController":"Examination_SeconViewController"])
            
            BusinessArr.add(["title":"历史试卷","icon":"高分试卷","viewController":"Exam_historylistViewController"])
            
            BusinessArr.add(["title":"积分排名","icon":"排行","viewController":"Integral_rankingViewController"])
            
            if myModel.type_id == ROLE_CUSTOMER || myModel.type_id == ROLE_PRODUCT {
                BusinessArr.add(["title":"自测","icon":"考试-(1)","viewController":"Exam_self_testingViewController"])
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return BusinessArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.bounds.size.width - 4)/3, height: (collectionView.bounds.size.height-4*4-135)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:BusinessListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusinessListCollectionViewCell", for: indexPath) as! BusinessListCollectionViewCell
        cell.backgroundColor = UIColor.white
        
        let dic:[String:String] =  BusinessArr.object(at: indexPath.row) as! [String:String]

        cell.titleLable.text = dic["title"]
        cell.iconImageView.image = UIImage(named: dic["icon"]!)
        cell.iconImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

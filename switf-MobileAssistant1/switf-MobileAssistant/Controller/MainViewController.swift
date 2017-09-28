//
//  MainViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/8/10.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var WebScrollView: UIScrollView!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var Already_visitedLabel: UILabel!
    @IBOutlet weak var Not_visitedLabel: UILabel!
    @IBOutlet weak var P_StockLabel: UILabel!
    @IBOutlet weak var P_BookLabel: UILabel!
    @IBOutlet weak var P_BillLabel: UILabel!
    @IBOutlet weak var P_MarketingLabel: UILabel!
    
    let userDefaults = UserDefaults()
    
    var myModel:UserEntity!
    
    var MainTableViewArr:NSMutableArray!

    var Already_visitedstrCount:NSString = "0"
    var Not_visitedstrCount:NSString = "0"
    
    var P_StockstrCount:NSString = "0"
    var P_BookstrCount:NSString = "0"
    var P_BillstrCount:NSString = "0"
    var P_MarketingstrCount:NSString = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "主页"
        //自定义对象读取
        let myModelData = userDefaults.data(forKey: "user_message")
        myModel = NSKeyedUnarchiver.unarchiveObject(with: myModelData!) as! UserEntity
        
        WebScrollView.contentSize = CGSize(width: WebScrollView.frame.size.width * 2,
                                        height: WebScrollView.frame.size.height)
        WebScrollView.backgroundColor = UIColor(red: 66/255.0, green: 187/255.0, blue: 233/255.0, alpha: 1)
        //是否显示水平滚动条
        WebScrollView.showsHorizontalScrollIndicator = false
        //是否显示竖直滚动条
        WebScrollView.showsVerticalScrollIndicator = false
        //设置分页滚动
        WebScrollView.isPagingEnabled = true
        
        
        let webView1 = UIWebView(frame: CGRect(x: 0, y: 0, width: WebScrollView.frame.size.width, height: WebScrollView.frame.size.height))
                
        webView1.isUserInteractionEnabled = false
        
        let url1 = "\("http://gzcmm.dayo.net.cn/cmm/charts.php?id=")\(myModel.user_id)"
        
        webView1.loadRequest(NSURLRequest(url: URL(string: url1)!) as URLRequest)

        WebScrollView.addSubview(webView1)
        

        let webView2 = UIWebView(frame: CGRect(x: WebScrollView.frame.size.width, y: 0, width: WebScrollView.frame.size.width, height: WebScrollView.frame.size.height))
        
        webView2.isUserInteractionEnabled = false
        
        let url2 = "\("http://gzcmm.dayo.net.cn/cmm/charts1.php?id=")\(myModel.user_id)"
        
        webView2.loadRequest(NSURLRequest(url: URL(string: url2)!) as URLRequest)
        
        WebScrollView.addSubview(webView2)
        
        self.getTask_NumData()
        
        MainTableViewArr = [
            ["color":"45, 215, 220","icon":"统一下单业务","title":"统一下单业务","message":"特号办理、台账登记、终端业务等"],
            ["color":"35, 159, 218","icon":"走访任务系统","title":"走访任务系统","message":"走访任务、走访轨迹、走访情况等"],
            ["color":"24, 90, 204" ,"icon":"crm"       ,"title":"CRM业务办理","message":"集团V网、彩铃、国际漫游等"],
            ["color":"45, 215, 220","icon":"平台"       ,"title":"订单中心"   ,"message":"订单需求发起、故障投诉等"],
            ["color":"45, 215, 220","icon":"在线考试"   ,"title":"考试系统"    ,"message":"考试、历史试卷、积分排名等"],
            ["color":"247, 173, 39","icon":"其他"       ,"title":"其他资料库"  ,"message":"产品资料库、营销活动信息库等"]]

        let cellNib = UINib(nibName: "MainTableViewCell", bundle: nil)
        
        tableView .register(cellNib, forCellReuseIdentifier: "MainTableViewCell")
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MainTableViewArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 80
    }

    //返回某行上应该显示的单元格
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        //定义一个cell标示符，用以区分不同的cell
//        let cellID : String = "cell"
//        
//        //从cell复用池中拿到可用的cell
//        /*
//         我们为什么要实现单元格的复用机制？
//         单元格每一个cell的生成都是要init alloc的，所以当我们滑动表格试图的时候会生成很多cell，无异于浪费了大量的内存
//         单元格的复用机制原理
//         一开始的时候我们创建了桌面最多能显示的单元格数，cell
//         当我们向下滚动表格试图的时候，单元格上部的内容会消失，下部的内容会出现，这个时候我们将上部分消失的单元格赋给下部分出现的单元格
//         因此我们就做到了只生成了屏幕范围可显示的单元格个数，就实现滑动表格试图时，以后不会再init alloc单元格cell了，从而实现了节省内存的原理
//         */
//        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as UITableViewCell!
//        
//        //检测，拿到一个可用的cell
//        if(cell == nil)
//        {
//            //创建新的cell
//            /*
//             UITableViewCellStyle.Default,    // 左侧显示textLabel（不显示detailTextLabel），imageView可选（显示在最左边）
//             UITableViewCellStyle.Value1,        // 左侧显示textLabel、右侧显示detailTextLabel（默认蓝色），imageView可选（显示在最左边）
//             UITableViewCellStyle.Value2,        // 左侧依次显示textLabel(默认蓝色)和detailTextLabel，imageView可选（显示在最左边）
//             UITableViewCellStyle.Subtitle    // 左上方显示textLabel，左下方显示detailTextLabel（默认灰色）,imageView可选（显示在最左边）
//             */
//            
//            cell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellID)
//            
//        }
//        
//        let dic:[String:String] =  MainTableViewArr!.object(at: indexPath.row) as! [String:String]
//        
//        //        //cell上文本
//        cell?.textLabel?.textColor = UIColor.black
//        cell?.textLabel?.text = dic["title"]
//        
//        return cell!

        let cell:MainTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        
        let dic:[String:String] =  MainTableViewArr!.object(at: indexPath.row) as! [String:String]
        
        let arr:Array = (dic["color"]?.components(separatedBy: ","))!

//        cell.ColorLabel.backgroundColor = UIColor.init(red: CGFloat((arr[0] as NSString).doubleValue/255.0), green: CGFloat((arr[1] as NSString).doubleValue/255.0), blue: CGFloat((arr[2] as NSString).doubleValue/255.0), alpha: 1)

        cell.ColorLabel.backgroundColor = Maco().RGBA(r: CGFloat((arr[0] as NSString).floatValue), g: CGFloat((arr[1] as NSString).floatValue), b: CGFloat((arr[2] as NSString).floatValue), a: 1)
        
        cell.titleLabel.text = dic["title"]
        cell.messageLabel.text = dic["message"]
        cell.iconImage.image = UIImage(named: dic["icon"]!)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let dic:[String:String] =  MainTableViewArr!.object(at: indexPath.row) as! [String:String]

        let vc = MainBaseViewController()
        
        vc.name = dic["title"]!
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getTask_NumData(){
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"home_page",
             "user_type":myModel.type_id,
             "user_id":myModel.user_id,
             "dep_id":myModel.dep_id,
             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state: NSNumber = backMsg.object(forKey: "state") as! NSNumber
            
            
            if state == 1{
                
                let pageArr = (backMsg.object(forKey: "content") as! NSString).components(separatedBy: ",")
                
                self.Already_visitedstrCount = pageArr[0] as NSString
                self.Not_visitedstrCount = pageArr[1] as NSString
                
                self.P_StockstrCount = pageArr[2] as NSString
                self.P_BookstrCount = pageArr[3] as NSString
                self.P_BillstrCount = pageArr[4] as NSString
                self.P_MarketingstrCount = pageArr[5] as NSString
            
                self.ChangeTitleColor()
                
            }
            
        }

    }
    
    func ChangeTitleColor()  {
        
         let Already_visitedstr:NSMutableAttributedString = NSMutableAttributedString(string: "本月已走访任务数 \(Already_visitedstrCount)")
        
        Already_visitedstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 181/255.0, green: 211/255.0, blue: 69/255.0, alpha: 1), range: NSRange.init(location: 9, length:Already_visitedstrCount.length))
        
        let Not_visitedstr:NSMutableAttributedString = NSMutableAttributedString(string: "本月剩余未走访任务数 \(Not_visitedstrCount)")
        
        Not_visitedstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 181/255.0, green: 211/255.0, blue: 69/255.0, alpha: 1), range: NSRange.init(location: 11, length:Not_visitedstrCount.length))
        
        let P_Stockstr:NSMutableAttributedString = NSMutableAttributedString(string: "终端退库 \(P_StockstrCount)")
        
        P_Stockstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 181/255.0, green: 211/255.0, blue: 69/255.0, alpha: 1), range: NSRange.init(location: 5, length:P_StockstrCount.length))
        
        let P_Bookstr:NSMutableAttributedString = NSMutableAttributedString(string: "台账登记 \(P_BookstrCount)")
        
        P_Bookstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 181/255.0, green: 211/255.0, blue: 69/255.0, alpha: 1), range: NSRange.init(location: 5, length:P_BookstrCount.length))
        
        let P_Billstr:NSMutableAttributedString = NSMutableAttributedString(string: "开具发票 \(P_BillstrCount)")
        
        P_Billstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 181/255.0, green: 211/255.0, blue: 69/255.0, alpha: 1), range: NSRange.init(location: 5, length:P_BillstrCount.length))
        
        let P_Marketingstr:NSMutableAttributedString = NSMutableAttributedString(string: "营销方案更改 \(P_MarketingstrCount)")
        
        P_Marketingstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 181/255.0, green: 211/255.0, blue: 69/255.0, alpha: 1), range: NSRange.init(location: 7, length:P_MarketingstrCount.length))
        
        self.Already_visitedLabel.attributedText = Already_visitedstr
        self.Not_visitedLabel.attributedText = Not_visitedstr
        self.P_StockLabel.attributedText = P_Stockstr
        self.P_BookLabel.attributedText = P_Bookstr
        self.P_BillLabel.attributedText = P_Billstr
        self.P_MarketingLabel.attributedText = P_Marketingstr
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

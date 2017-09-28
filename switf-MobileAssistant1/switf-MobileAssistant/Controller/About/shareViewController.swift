//
//  shareViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/25.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit
import MessageUI

class shareViewController: ZXYBaseViewController,MFMessageComposeViewControllerDelegate{

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "App分享"
        
        let submitBtn = self.setNaviRightBtnWithTitle(title: "短信分享")
        
        submitBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 44)
        
        submitBtn.addTarget(self, action: #selector(submitBtnClicked), for: UIControlEvents.touchUpInside)
        
        let url = "http://pub.dayo.net.cn/gzcmm/download/index.php?tt=1"

        let request = NSURLRequest(url: NSURL(string: url)! as URL)

        webView.loadRequest(request as URLRequest)
        
        
    }
    
    func submitBtnClicked() {
        
        self.setnewsRead()
        
    }
    
    func setnewsRead() {
        
        let process=CommServer()
        
        let parameters:[String:String] = ["method":"sms_share"]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state = backMsg.object(forKey: "state") as! NSNumber
            
            if state == 1 {
                
                print("\(String(describing: backMsg.object(forKey: "content")))")
                if MFMessageComposeViewController.canSendText()
                {
                    let controller = MFMessageComposeViewController()
                    //设置短信内容
                    controller.body = backMsg.object(forKey: "content") as? String
                    //设置代理
                    controller.messageComposeDelegate = self
                    //打开界面
                    self.present(controller, animated: true, completion: { () -> Void in
                        
                    })
                }
                else
                {
                    print("本设备不能发送短信")
                }
                
            }
            
        }
        
    }
    
    //发送短信结束后调用此代理方法
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult)
    {
        controller.dismiss(animated: true, completion: nil)
        
        switch result.rawValue
            
        {
        case MessageComposeResult.sent.rawValue:
            print("短信已发送")
        case MessageComposeResult.cancelled.rawValue:
            print("短信取消发送")
        case MessageComposeResult.failed.rawValue:
            print("短信发送失败")
        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

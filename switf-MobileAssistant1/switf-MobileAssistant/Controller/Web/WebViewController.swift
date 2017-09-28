

//
//  WebViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/9/15.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class WebViewController: ZXYBaseViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var titleName = ""
    var newsId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = titleName
        
        let url = NEWS_URL + "?id=" + newsId
        
        let request = NSURLRequest(url: NSURL(string: url)! as URL)
        
        webView.loadRequest(request as URLRequest)
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

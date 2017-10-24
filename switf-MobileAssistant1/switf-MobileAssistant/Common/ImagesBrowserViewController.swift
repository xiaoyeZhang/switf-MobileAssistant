//
//  ImagesBrowserViewController.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 2017/10/24.
//  Copyright © 2017年 zxy. All rights reserved.
//

import UIKit

class ImagesBrowserViewController: ZXYBaseViewController {

    @IBOutlet weak var ScrollView: UIScrollView!
    
    var imagesNameArray:NSArray = []
    
    var imagesMuArr:NSMutableArray = []
    
    
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "合同"
        
        imagesMuArr = NSMutableArray(array: imagesNameArray)
        
        imagesMuArr.remove("")
        
        ScrollView.contentSize = CGSize(width: ScrollView.frame.size.width * CGFloat(imagesMuArr.count),
                                           height: 0)

        //是否显示水平滚动条
        ScrollView.showsHorizontalScrollIndicator = false
        //是否显示竖直滚动条
        ScrollView.showsVerticalScrollIndicator = false
        //设置分页滚动
        ScrollView.isPagingEnabled = true

        
        for i in 0..<imagesMuArr.count {
            //创建imageView
            let imageView = UIImageView(frame: CGRect(x: CGFloat(i)*ScrollView.frame.size.width, y: 0, width: ScrollView.frame.size.width, height: self.view.frame.size.height))
            
            imageView.contentMode = .scaleAspectFit
            
            //添加图片

            var imageUrl:String = ""
            
            if type == "1" {
                
                imageUrl = String(format: "%@%@", TERMINAL_PHOTO_URL,imagesMuArr[i] as! String)
            }else{
                imageUrl = String(format: "%@%@.jpg", TERMINAL_PHOTO_URL,imagesMuArr[i] as! String)
            }
            
            if let url = URL(string: imageUrl) {
                
                imageView.downloadedFrom(url: url)
                
            }

            //打开用户交互
            imageView.isUserInteractionEnabled = true
            //把imageView添加到滚动视图上
            ScrollView.addSubview(imageView)
            
        }

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

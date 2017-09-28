//
//  AppDelegate.swift
//  switf-MobileAssistant
//
//  Created by 张晓烨 on 16/9/20.
//  Copyright © 2016年 zxy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nav = UINavigationController()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        let navigationBarAppearance = UINavigationBar.appearance()
//
//        navigationBarAppearance.setBackgroundImage(UIImage(named: "bg"), for: .default)
        
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let LoginVc = LoginViewController()
        
        nav = UINavigationController(rootViewController: LoginVc)
        
        nav.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        
        nav.navigationBar.setBackgroundImage(UIImage(named: "bg"), for: .default)

        nav.navigationBar.shadowImage = UIImage()
        
        nav.navigationBar.isTranslucent = false
    
        window?.rootViewController = nav
        
        window?.makeKeyAndVisible()
        
        self.checkUpdate()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func checkUpdate() {
        
        let process=CommServer()
        
        let parameters:[String:String] =
            ["method":"update_ios_version",
             "version":APPClientVersion,
             
             ]
        
        process.processWithBlock(cmdStr: parameters) { (backMsg) in
            
            let state: NSNumber = backMsg.object(forKey: "result") as! NSNumber
            
            if state == 2{
                
                let info = backMsg.object(forKey: "info") as! [String:String]
                
                let alertController = UIAlertController(title: "更新提示",message: info["content"],preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .default, handler:{
                    action in
                    let url = NSURL(string: info["url"]!)
                    UIApplication.shared.openURL(url! as URL)
                    
                })
                let otherAction = UIAlertAction(title: "取消", style: .cancel, handler:{
                    action in
                    
                    
                })
                alertController.addAction(cancelAction)
                alertController.addAction(otherAction)
                self.nav.present(alertController, animated: true, completion: nil)
            }else if state == 3{ //强制更新
                
                let info = backMsg.object(forKey: "info") as! [String:String]
                
                let alertController = UIAlertController(title: "更新提示",message: info["content"],preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .default, handler:{
                    action in
                    let url = NSURL(string: info["url"]!)
                    UIApplication.shared.openURL(url! as URL)
                    
                })
                alertController.addAction(cancelAction)
                self.nav.present(alertController, animated: true, completion: nil)
            }
            
        }

    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        switch shortcutItem.type {
        case "-11.UITouchText.share":
            let items = ["hello 3D Touch"]
            let activityVC = UIActivityViewController(
                activityItems: items,
                applicationActivities: nil)
            self.window?.rootViewController?.present(activityVC, animated: true, completion: { () -> Void in
                
            })
        default:
            break
        }
        
    }
    
}


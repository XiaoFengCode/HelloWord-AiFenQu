//
//  AppDelegate.swift
//  iFenQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//


import UIKit
import IQKeyboardManager
import Bugly
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.setSDKInfo()
        self.monitorNet()
        self.initViewStatus()
        
        let tabVc = BaseTabBarViewController()
        
        self.window?.rootViewController = BaseNavigationController.init(rootViewController: tabVc)
        
        Network.dataRequest(url: Url.getEnvironment() + "v1/cards", param: nil, reqmethod: .GET) { (reuslt) in
            
        }
        
        return true
    }

    
    ///初始化一些基本设置，颜色等
    func initViewStatus() {
        UITextField.appearance().tintColor = UIColor.lightGray
        let color = UIColor.init(red: 255/255, green: 171/255, blue: 0, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue):color], for: .selected)
    }
    
    ///配置sdk信息
    func setSDKInfo() {
        Bugly.start(withAppId: "6cef74c8c2")
        
        IQKeyboardManager.shared().isEnabled = true
    }
    
    ///监听网络
    func monitorNet() {
        let net = AFNetworkReachabilityManager.shared()
        net.setReachabilityStatusChange { (status) in
            switch status {
            case .notReachable:
                print("")
            case .unknown:
                print("")
            case .reachableViaWWAN:
                print("")
            case .reachableViaWiFi:
                print("")
            }
        }
        net.startMonitoring()
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


}

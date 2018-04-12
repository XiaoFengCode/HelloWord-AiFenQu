//
//  BootPageViewController.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///启动页
import UIKit
import WebKit
class BootPageViewController: BaseViewController {

    ///返回事件调用block
    var loadMainBlock: (() -> Void)?
//    var webView: WKWebView!
    lazy var webView = { () -> WKWebView in
        let web = WKWebView.init(frame: self.view.bounds)
        web.uiDelegate = self
        web.navigationDelegate = self
        return web
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        Network.dataRequest(url: Url.getBootPage(), param: nil, reqmethod: .GET) { (result) in
            
        }
    }

    

}

extension BootPageViewController: WKNavigationDelegate,WKUIDelegate{
    
}

//
//  ShopDetailDescribeView.swift
//  IFenQu
//
//  Created by 朱晓峰 on 2018/4/22.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
protocol ShopDetailDescribeViewDelegate {
    func webDidLoad()
}
///商品详情底部描述视图

import UIKit

class ShopDetailDescribeView: UIView,UIScrollViewDelegate,UIWebViewDelegate {

    var topView: UIView!
    var scrollView: UIScrollView!
    
    var lineView: UIView!
    var delegate: ShopDetailDescribeViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 50))
        topView.backgroundColor = UIColor.white
        self.addSubview(topView)
//        topView.mas_makeConstraints { (make) in
//            make?.top.equalTo()(self.mas_top)
//            make?.height.equalTo()(50)
//            make?.left.equalTo()(self.mas_left)
//            make?.right.equalTo()(self.mas_right)
//        }
        let btnName = ["产品详情","购前说明","常见问答"]
        lineView = UIView.init(frame: CGRect.init(x: SCREEN_Width/6 - btnName[0].getTextSize(font: 14).width/2, y: topView.frame.maxY - 2, width: btnName[0].getTextSize(font: 14).width, height: 2))
        lineView.backgroundColor = xyellow
        for i in 0..<3 {
            let btn = UIButton.init(frame: CGRect.init(x: SCREEN_Width/3 * CGFloat(i), y: 18, width: SCREEN_Width/3, height: 30))
            btn.setTitle(btnName[i], for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.darkGray, for: .normal)
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(btnAction(btn:)), for: .touchUpInside)
            if i == 0 {
//                self.btnAction(btn: btn)
            }
            topView.addSubview(btn)
//            btn.mas_makeConstraints { (make) in
//                make?.bottom.equalTo()(topView.mas_bottom)?.offset()(-2)
//                make?.height.equalTo()(30)
//                make?.left.equalTo()(self.mas_left)?.offset()(SCREEN_Width/3 * CGFloat(i))
//                make?.width.equalTo()(SCREEN_Width/3)
//            }
        }
        
        
        topView.addSubview(lineView)

//        lineView.mas_makeConstraints { (make) in
//            make?.bottom.equalTo()(topView.mas_bottom)?.offset()(-2)
//            make?.height.equalTo()(30)
//            make?.left.equalTo()(self.mas_left)?.offset()(SCREEN_Width/3 )
//            make?.width.equalTo()(btnName[0].getTextSize(font: 14).width, height: 2).width)
//        }
        
        scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 52, width: SCREEN_Width, height: 300))
        scrollView.contentSize = CGSize.init(width: SCREEN_Width*3, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.addSubview(scrollView)
        
//        scrollView.mas_makeConstraints { (make) in
//            make?.top.equalTo()(topView.mas_bottom)?.offset()(2)
//            make?.height.equalTo()(200)
//            make?.left.equalTo()(self.mas_left)
//            make?.right.equalTo()(self.mas_right)
//        }
//        let scrolViewBg = UIView.init()
//        scrollView.addSubview(scrolViewBg)
//        scrolViewBg.mas_makeConstraints { (make) in
//            make?.edges.equalTo()(scrollView)
//        }
        web1 = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 300))
        web1.delegate = self
        scrollView.addSubview(web1)
        web2 = UIWebView.init(frame: CGRect.init(x: SCREEN_Width, y: 0, width: SCREEN_Width, height: 300))
        web2.delegate = self
        scrollView.addSubview(web2)
        web3 = UIWebView.init(frame: CGRect.init(x: SCREEN_Width * CGFloat(2), y: 0, width: SCREEN_Width, height: 300))
        web3.delegate = self
        scrollView.addSubview(web3)
//
//        web1.mas_makeConstraints { (make) in
//            make?.left.equalTo()(self.mas_left)
//            make?.top.equalTo()(scrollView.mas_top)
//            make?.bottom.equalTo()(scrollView.mas_bottom)
//            make?.width.equalTo()(SCREEN_Width)
//        }
//        web2.mas_makeConstraints { (make) in
//            make?.left.equalTo()(web1.mas_right)
//            make?.top.equalTo()(scrollView.mas_top)
//            make?.bottom.equalTo()(scrollView.mas_bottom)
//            make?.width.equalTo()(SCREEN_Width)
//        }
//        web3.mas_makeConstraints { (make) in
//            make?.left.equalTo()(web2.mas_right)
//            make?.top.equalTo()(scrollView.mas_top)
//            make?.bottom.equalTo()(scrollView.mas_bottom)
//            make?.width.equalTo()(SCREEN_Width)
//            make?.right.equalTo()(scrollView.mas_right)
//        }
    }
    var web1: UIWebView!
    var web2: UIWebView!
    var web3: UIWebView!
    
    @objc func btnAction(btn:UIButton) {
        let i = btn.tag - 1000
        for view in topView.subviews {
            if view is UIButton {
                let b = view as! UIButton
                if b.tag == i {
                    b.setTitleColor(xlightGray, for: .normal)
                } else {
                    b.setTitleColor(UIColor.darkGray, for: .normal)
                }
            }
        }
        UIView.animate(withDuration: 0.3) {
            self.lineView.x = SCREEN_Width/6 + SCREEN_Width/3 * CGFloat(i) - self.lineView.width/2
        }
        scrollView.setContentOffset(CGPoint.init(x: SCREEN_Width * CGFloat(i), y: 0), animated: true)
       
    }
    
    func setWebModel(model:[ShopDetailWebModel]) {
        for m in model {
            switch m.contentLocationType {
            case "DETAILS":
                web1.loadHTMLString(m.content, baseURL: nil)
            case "BUY_EXPLAIN":
                web2.loadHTMLString(m.content, baseURL: nil)
            case "QA":
                web3.loadHTMLString(m.content, baseURL: nil)
            default:
                print("")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
//        scrollView.mas_updateConstraints { (make) in
//            make?.height.equalTo()(webView.scrollView.contentSize.height)
//        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x == 0 {
            let btn = UIButton()
            btn.tag = 1000
            btnAction(btn: btn)
        } else if scrollView.contentOffset.x == SCREEN_Width {
            let btn = UIButton()
            btn.tag = 1001
            btnAction(btn: btn)
        } else if scrollView.contentOffset.x == SCREEN_Width * CGFloat(2) {
            let btn = UIButton()
            btn.tag = 1002
            btnAction(btn: btn)
        }
        
    }
    
}

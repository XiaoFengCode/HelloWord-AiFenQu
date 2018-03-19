//
//  AboutViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/8.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///关于

import UIKit

class AboutViewController: BaseViewController {

    var contentTableView: UITableView!
    
    var dataSource: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "关于我们"
        dataSource = ["使用条款","隐私声明","安全管理声明","退换货政策","客服热线        400-605-5188","商务合作        BD@ifenqu.com","当前版本        V1.0"]
        contentTableView = UITableView.init(frame: self.view.bounds, style: .plain)
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.rowHeight = 44
        contentTableView.tableFooterView = UIView()
        contentTableView.isScrollEnabled = false
        self.view.addSubview(contentTableView)
        
        
    }

    
}

extension AboutViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///跳转目标地址
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        if headerView == nil {
            headerView = UITableViewHeaderFooterView.init(reuseIdentifier: "header")
            
            let imageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 200))
            imageView.image = UIImage.init(named: "u1352")
            headerView?.contentView.addSubview(imageView)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            
            cell?.selectionStyle = .none
            let isShow = indexPath.row <= 3
            cell?.accessoryType = isShow ? .disclosureIndicator : .none
        }
        
        cell?.textLabel?.text = dataSource[indexPath.row]
        return cell!
    }
}

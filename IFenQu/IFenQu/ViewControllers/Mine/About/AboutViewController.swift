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

    private var contentTableView: UITableView!
    
    private var dataSource: [String]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBasic()
        
    }
    
    ///初始化基本设置
    private func initBasic() {
        self.navigationItem.title = "关于我们"
        
        dataSource = ["使用条款","隐私声明","安全管理声明","退换货政策","当前版本        V1.0","客服热线        400-605-5188","商务合作        BD@ifenqu.com"]
        contentTableView = UITableView.init(frame: self.view.bounds, style: .grouped)
        
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
        return 4 - section
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let size = UIImage.init(named: "Group 744")?.size {
            return section == 0 ? size.height * size.width / SCREEN_Width : 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            return nil
        }
        
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        if headerView == nil {
            headerView = UITableViewHeaderFooterView.init(reuseIdentifier: "header")
            let imageView = UIImageView.init()
            imageView.image = UIImage.init(named: "Group 744")
            headerView?.contentView.addSubview(imageView)
            
            imageView.mas_makeConstraints({ (make) in
                make?.left.equalTo()(headerView?.mas_left)
                make?.right.equalTo()(headerView?.mas_right)
                make?.top.equalTo()(headerView?.mas_top)
                make?.bottom.equalTo()(headerView?.mas_bottom)
            })
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
            cell?.selectionStyle = .none
            let isShow = indexPath.section == 0
            cell?.accessoryType = isShow ? .disclosureIndicator : .none
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        }
        if indexPath.section == 0 {
            cell?.textLabel?.text = dataSource[indexPath.row]
        } else {
            cell?.textLabel?.text = dataSource[indexPath.row + 4]
        }
        return cell!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

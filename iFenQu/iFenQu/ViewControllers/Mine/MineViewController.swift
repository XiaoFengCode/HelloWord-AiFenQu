//
//  MineViewController.swift
//  AiFeiQu
//
//  Created by 朱晓峰 on 2018/3/7.
//  Copyright © 2018年 朱晓峰. All rights reserved.
//
///我的
import UIKit

class MineViewController: BaseViewController {

    var tableView: UITableView!
    var tableCellData: [(imageName:String,text:String)] = [
        ("Group 629","积分"),
        ("Group 541","我的订单"),
        ("Group 549","优惠券"),
        ("Group 552","权益券")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
    }
    var goodsModels = [ShopModel]() {
        didSet{
            shopCollectView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if goodsModels.count == 0 && CacheManager.manager.shopGoodModels != nil {
            goodsModels = CacheManager.manager.shopGoodModels!
        }
    }
    
    func initTableView() {
        tableView = UITableView.init(frame: self.view.bounds, style: .plain)
        self.view.addSubview(tableView)
        tableView.register(UINib.init(nibName: "MineTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        let header = MineHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 150))
        let headerSuperView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 170))
        headerSuperView.addSubview(header)
        headerSuperView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = headerSuperView
        tableView.tableFooterView = initFooterView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.backgroundColor = xlightGray
        
    }
    
    ///底部商品视图
    private func initFooterView() -> UIView {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_Width, height: 220))
        let layout = UICollectionViewFlowLayout.init()
        let height: CGFloat = 215
        layout.itemSize = CGSize.init(width: SCREEN_Width/3, height: height)
        layout.scrollDirection = .horizontal
        shopCollectView = UICollectionView.init(frame: CGRect.init(x: 0, y: 20, width: SCREEN_Width, height: height), collectionViewLayout: layout)
        
        shopCollectView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        shopCollectView.dataSource = self
        shopCollectView.delegate = self
        shopCollectView.backgroundColor = UIColor.white
        shopCollectView.isScrollEnabled = false
        footerView.addSubview(shopCollectView)
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    var shopCollectView: UICollectionView!
    
}

extension MineViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCellData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MineTableViewCell
        cell.setModel(model: tableCellData[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CouponViewController()
        vc.titleSting = tableCellData[indexPath.row].text
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension MineViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if  goodsModels.count > 0 {
            return 3
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShopCollectionViewCell
        cell.setModel(model: goodsModels[indexPath.row + 6])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ///把选中的模型传递下一步
        let shopDetailVc = ShopDetailViewController()
       shopDetailVc.shopModel = goodsModels[indexPath.row + 6]
        self.navigationController?.pushViewController(shopDetailVc, animated: true)
    }
}

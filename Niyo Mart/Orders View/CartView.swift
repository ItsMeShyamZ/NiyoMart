//
//  CartView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 26/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class CartView: UIViewController {
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var cartTabBar: UITabBar!
    @IBOutlet weak var cartTabBarItem: UITabBarItem!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var shoppingBtnTpd: UIButton!
    @IBOutlet weak var checkOutBtn: UIButton!
    
    @IBAction func backBtnTpd(_ sender: Any) {
    }
    
    @IBAction func shoppingBtnTpd(_ sender: Any) {
        let view = HomePageView.init(nibName: "HomePageView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    @IBAction func checkOutBtnTpd(_ sender: Any) {
        let view = DeliveryAddressView.init(nibName: "DeliveryAddressView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func searchBtnTpd(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cartTableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "listCell")
        cartTabBar.delegate = self
        cartTabBar.selectedItem = cartTabBarItem
        emptyView.isHidden = true
//        checkOutBtn.isHidden = true

    }
}

extension CartView : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            let view = HomePageView.init(nibName: "HomePageView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: false)
        }else if item.tag == 1 {
            let view = CartView.init(nibName: "CartView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: false)
        }else if item.tag == 2 {
            let view = ProfileOptionsView.init(nibName: "ProfileOptionsView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: false)
        }else if item.tag == 3 {
            
        }
    }
}



extension CartView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CartCell = cartTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! CartCell
        cell.setDataAndIcons(callFor: "cart")
        return cell
    }
    
    
}

//
//  ProductListView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 25/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class ProductListView: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var productTableView: UITableView!
    
    
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func searchButtonTpd(_ sender: Any) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "listCell")

    }
}

extension ProductListView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductCell = productTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ProductCell
        
        if indexPath.row == 2 {
            cell.addButton.isHidden = true
            cell.qtyView.isHidden = false
            cell.deleteBtn.isHidden = true
        }else {
            cell.addButton.isHidden = false
            cell.qtyView.isHidden = true
            cell.deleteBtn.isHidden = true
        }
        
        return cell
    }
    
    
}

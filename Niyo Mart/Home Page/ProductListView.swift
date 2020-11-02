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
    
    var category : CategoryModel?
    var ProductList : [ProductModel] = []
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func searchButtonTpd(_ sender: Any) {
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadDataFromApi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "listCell")

    }
}

extension ProductListView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProductCell = productTableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ProductCell
        cell.setupDate(data: self.ProductList[indexPath.row])
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
extension ProductListView{
    func loadDataFromApi() -> Void {
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        showLoader(withTitle: "", and: "")
        ApiManager.shared.fetchProduct(categoryid:"\(1/*self.category?.category_id ?? 0*/)") { (productlist, errorMsg) in
            if errorMsg == "" {
                self.ProductList = productlist
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.productTableView.reloadData()
                }
            }else {
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.showToast(message: errorMsg)
                }
            }
        }
        
    }
}

//
//  UserAddressView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 20/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class UserAddressView: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var addAddressBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var addressTableView: UITableView!
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var termsDetailLabel: UILabel!
    
    var addressArray : [UserAddressStruct] = []
    
    
    @IBAction func termsButtonTpd(_ sender: Any) {
        
    }
    
    @IBAction func cancelBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAddressbtnTpd(_ sender: Any) {
        let view = NewAddressView.init(nibName: "NewAddressView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        if UtilCollections.shared.getReloadView() {
            self.showLoader(withTitle: "", and: "")
            loadDataFromApi()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressTableView.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "detailsCell")
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        self.showLoader(withTitle: "", and: "")
        loadDataFromApi()
    }
}

extension UserAddressView {
    
    func loadDataFromApi() -> Void {
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
     
        ApiManager.shared.fetchUserAddressApi { (userAddressData, errorMsg) in
            if errorMsg == "" {
                self.addressArray = userAddressData
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.addressTableView.reloadData()
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

extension UserAddressView : addressCellDelegate {
    func defaultBtnTpd(clickedCell: AddressCell) {
        if let clickedIndex = addressTableView.indexPath(for: clickedCell) {
            setToDefaultAddress(id: "\(addressArray[clickedIndex.row].id ?? 0)")
        }
    }
    
    func setToDefaultAddress(id : String?) {
        if let addressId = id {
            self.showLoader(withTitle: "", and: "")
            ApiManager.shared.setToDefaultAddressApi(addressId: addressId) { (responseData) in
                if responseData.code == 200 {
                    DispatchQueue.main.async {
                        
                        self.loadDataFromApi()
                    }
                }else {
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.showToast(message: responseData.status ?? "Failed")
                    }
                }
            }
        }else {
            DispatchQueue.main.async {
                self.hideLoader()
                self.showToast(message: "Failed")
            }
        }
    }
    
    
}

extension UserAddressView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addressArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AddressCell = addressTableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! AddressCell
        cell.delegate = self
        cell.loadAddress(addressData: addressArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addressTableView.deselectRow(at: indexPath, animated: false)
        let view = NewAddressView.init(nibName: "NewAddressView", bundle: nil)
        view.isForUpdate = true
        view.tappedAddressData = addressArray[indexPath.row]
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteUser = UITableViewRowAction(style: .default, title: "\u{267A}\n Delete") { (action, indexPath) in
            self.removeAddress(addressId: "\(self.addressArray[indexPath.row].id ?? 0)")
        }
        deleteUser.backgroundColor = UIColor.red
        return [deleteUser]

    }
    
    func removeAddress(addressId : String?) {
        if let id = addressId {
            self.showLoader(withTitle: "", and: "")
            ApiManager.shared.deleteUserAddressApi(addressId: id) { (responseData) in
                if responseData.code == 200 {
                    DispatchQueue.main.async {
                        
                        self.loadDataFromApi()
                    }
                }else {
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.showToast(message: responseData.status ?? "Failed")
                    }
                }
            }
        }
    }
}

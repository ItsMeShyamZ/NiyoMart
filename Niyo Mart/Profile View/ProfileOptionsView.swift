//
//  ProfileOptionsView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 17/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class ProfileOptionsView: UIViewController {
    
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var userVIew: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var logInIdLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var accounttabBar: UITabBar!
    @IBOutlet weak var homeTabBarItem: UITabBarItem!
    @IBOutlet weak var cartTabitem: UITabBarItem!
    @IBOutlet weak var accountTabBarItem: UITabBarItem!
    
    
    
    var imageArray = [UIImage(named: "edit"), UIImage(named: "shippingAddress"), UIImage(named: "shippingAddress"), UIImage(named: "orderHistory"), UIImage(named: "order"), UIImage(named: "niyoContact"),UIImage(named: "notifications"), UIImage(named: "logout"),]
    var titleArray = ["Edit Profile", "Shipping Address", "Reward Points" , "Order History","Track Order","Niyo Contact","Terms & Conditions","Log Out"]
    var profileData : MyProfileStruct?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        profileTableView.register(UINib(nibName: "ProfileOptionsCell", bundle: nil), forCellReuseIdentifier: "optionsCell")
        accounttabBar.delegate = self
        accounttabBar.selectedItem = accountTabBarItem
//        showLoader(withTitle: "", and: "")
        loadUi()
        loadProfileDetailsApi()
    }
}


extension ProfileOptionsView {
    
    private func loadUi() -> Void {
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()

    }
    
    private func loadProfileDetailsApi() -> Void {
        ApiManager.shared.getProfileDetailsApi { (profileData) in
            self.profileData = profileData
            DispatchQueue.main.async {
                self.userNameLabel.text = self.replaceUserName(firstName: "\(profileData.first_name ?? "")", lastName: "\(profileData.last_name ?? "")")
                self.logInIdLabel.text = "Sign-In Id : \(DataLoad.shared.getUserName())"
//                self.hideLoader()
                
            }
            
        }
    }
    
    private func replaceUserName(firstName : String?, lastName : String?) -> String {
        if let fName = firstName, let lName = lastName {
            if fName.isEmpty || fName == "" {
                return "Niyo Mart User"
            }else {
                return "\(fName) \(lName)"
            }
        }else {
            return "Niyo Mart User"
        }
    }
    
}

extension ProfileOptionsView : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.selectedItem?.tag == 0 {
            let view = HomePageView.init(nibName: "HomePageView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: false)
        }else if tabBar.selectedItem?.tag == 1 {
            let view = CartView.init(nibName: "CartView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: false)

        }else if tabBar.selectedItem?.tag == 2 {

        }else if tabBar.selectedItem?.tag == 3 {
        
        }
    }
}

extension ProfileOptionsView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ProfileOptionsCell = profileTableView.dequeueReusableCell(withIdentifier: "optionsCell", for: indexPath) as! ProfileOptionsCell
        cell.titleLabel.text = titleArray[indexPath.row]
        cell.titleImgView.image = imageArray[indexPath.row]
        if titleArray[indexPath.row] == "Log Out" {
            cell.nextImgView.isHidden = true
        }else {
            cell.nextImgView.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTableView.deselectRow(at: indexPath, animated: false)
        
        let tpdIndexCell : ProfileOptionsCell = profileTableView.cellForRow(at: indexPath) as! ProfileOptionsCell
        
        if tpdIndexCell.titleLabel.text == "Niyo Contact" {
            let view = NiyoMartContactView.init(nibName: "NiyoMartContactView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: true)
        }else if tpdIndexCell.titleLabel.text == "Order History" {
            let view = OrderHistoryView.init(nibName: "OrderHistoryView", bundle: nil)
            view.callFor = "history"
            self.navigationController?.pushViewController(view, animated: true)
        }else if tpdIndexCell.titleLabel.text == "Track Order" {
            let view = OrderHistoryView.init(nibName: "OrderHistoryView", bundle: nil)
            view.callFor = "tracking"
            self.navigationController?.pushViewController(view, animated: true)
        }else if tpdIndexCell.titleLabel.text == "Edit Profile" {
            let view = UserProfileView.init(nibName: "UserProfileView", bundle: nil)
            view.userProfileData = profileData
            self.navigationController?.pushViewController(view, animated: true)
        }else if tpdIndexCell.titleLabel.text == "Shipping Address" {
            let view = UserAddressView.init(nibName: "UserAddressView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
}


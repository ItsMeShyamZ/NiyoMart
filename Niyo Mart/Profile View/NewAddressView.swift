//
//  NewAddressView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 19/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class NewAddressView: UIViewController {
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var street1TextView: UITextView!
    @IBOutlet weak var street2TextView: UITextView!
    @IBOutlet weak var districtTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var pinCodeTextField: UITextField!
    @IBOutlet weak var landMarkTextField: UITextField!
    
    var isForUpdate = false
    var tappedAddressData : UserAddressStruct?
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func saveButtonTpd(_ sender: Any) {
        validateAndSend()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UtilCollections.shared.setReload = false
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        loadForUi()
    }

}

extension NewAddressView {
    
    func loadForUi() -> Void {
        street1TextView.font = UtilCollections.shared.getTextFont()
        street2TextView.font = UtilCollections.shared.getTextFont()
        cityTextField.font = UtilCollections.shared.getTextFont()
        districtTextField.font = UtilCollections.shared.getTextFont()
        stateTextField.font = UtilCollections.shared.getTextFont()
        pinCodeTextField.font = UtilCollections.shared.getTextFont()
        landMarkTextField.font = UtilCollections.shared.getTextFont()
        saveButton.titleLabel?.font = UtilCollections.shared.getDoneTextFont()
        if isForUpdate {
            street1TextView.text = tappedAddressData?.street1
            street2TextView.text = tappedAddressData?.street2
            cityTextField.text = tappedAddressData?.city
            districtTextField.text = tappedAddressData?.district
            stateTextField.text = tappedAddressData?.state
            pinCodeTextField.text = tappedAddressData?.pincode
            landMarkTextField.text = tappedAddressData?.landmark
            saveButton.setTitle("Update", for: .normal)
        }else {
            saveButton.setTitle("Save", for: .normal)
        }
    }
    
    private func validateAndSend() -> Void {
        if let pinCode = pinCodeTextField.text, let state = stateTextField.text, let dist = districtTextField.text, let city = cityTextField.text, let landMark = landMarkTextField.text {
            if pinCode.isEmpty && state.isEmpty && landMark.isEmpty {
                showAlert(title: "Empty Fields", message: "Please fill the address")
            }else if pinCode.isEmpty{
                showAlert(title: "PINCODE field is empty", message: "")
            }else if state.isEmpty{
                 showAlert(title: "State field is empty", message: "")
            }else if dist.isEmpty{
                 showAlert(title: "District field is empty", message: "")
            }else if city.isEmpty{
                 showAlert(title: "City field is empty", message: "")
            }else if landMark.isEmpty {
                showAlert(title: "Landmark field is empty", message: "")
            }else {
                UtilCollections.shared.setReload = true
                if isForUpdate {
                    ApiManager.shared.updateAddressApi(street1: street1TextView.text ?? "", street2: street2TextView.text ?? "", city: city, district: dist, state: state, landMark: landMark, pincode: pinCode) { (responseData) in
                        
                        if responseData.code == 200 {
                            DispatchQueue.main.async {
                                self.navigationController?.popViewController(animated: false)
                            }
                            
                        }else {
                            DispatchQueue.main.async {
                                self.showToast(message: responseData.result ?? "failed")
                            }
                        }
                    }
                }else {
                    ApiManager.shared.addAddressApi(street1: street1TextView.text ?? "", street2: street2TextView.text ?? "", city: city, district: dist, state: state, landMark: landMark, pincode: pinCode) { (responseData) in
                        if responseData.code == 200 {
                            DispatchQueue.main.async {
                                self.navigationController?.popViewController(animated: false)
                            }
                            
                        }else {
                            DispatchQueue.main.async {
                                self.showToast(message: responseData.result ?? "failed")
                            }
                        }
                    }
                }
            }
        }else {
            showAlert(title: "Empty Fields", message: "Please fill the address")
        }
    }
    
    private func showAlert(title : String, message : String) {
        let loginAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        loginAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (okTpd) in
            
        }))
        self.present(loginAlert, animated: true, completion: nil)
    }
    
}

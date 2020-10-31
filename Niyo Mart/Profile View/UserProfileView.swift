//
//  UserProfileView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 19/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

typealias userData = (String,String,String,String)

class UserProfileView: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var firstNameTextFld: UITextField!
    @IBOutlet weak var lastNameTextFld: UITextField!
    
    @IBOutlet weak var genderSegmentCtrl: UISegmentedControl!
    @IBOutlet weak var dobTextFld: UITextField!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    
    var datePicker = UIDatePicker()
    var userProfileData : MyProfileStruct?
    var gender = ""
    var userDob = ""
    
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func genderSegTpd(_ sender: Any) {
        print("genderSegTpd : \(genderSegmentCtrl.selectedSegmentIndex)")
        switch genderSegmentCtrl.selectedSegmentIndex {
        case 0:
            gender = "male"
        case 1:
            gender = "female"
        case 2:
            gender = "others"
        default:
            break
        }
    }
    
    @IBAction func genderValueChanged(_ sender: Any) {
        print("genderSegTpd : \(genderSegmentCtrl.selectedSegmentIndex)")
        switch genderSegmentCtrl.selectedSegmentIndex {
        case 0:
            gender = "male"
        case 1:
            gender = "female"
        case 2:
            gender = "others"
        default:
            break
        }
    }
    @IBAction func termsBtnTpd(_ sender: Any) {
        if termsBtn.tag == 0 {
            termsBtn.tag = 1
            termsBtn.setImage(UIImage(named: "circleUnSelect"), for: .normal)
        }else if termsBtn.tag == 1 {
            termsBtn.tag = 0
            termsBtn.setImage(UIImage(named: "checked"), for: .normal)
        }
    }
    
    @IBAction func cancelBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextBtnTpd(_ sender: Any) {
        if termsBtn.tag == 0 {
            validateAndSend()
        }else {
            showAlert(title: "Please Accept Terms and Conditions", msg: "")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genderSegmentCtrl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        showDatePicker()
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        loadData()
        
    }
}

extension UserProfileView {
    
    private func loadData() -> Void {

        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        firstNameTextFld.text = userProfileData?.first_name
        lastNameTextFld.text = userProfileData?.last_name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let todayDate = dateFormatter.date(from: userProfileData?.user_dob ?? "") ?? Date()
        
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let formattedDate = dateFormatter.string(from: todayDate)
        dobTextFld.text = "\(formattedDate)"
        userDob = userProfileData?.user_dob ?? ""
        gender = userProfileData?.user_gender ?? ""
        setGender()
    }
    
    private func setGender() {
        if userProfileData?.user_gender == "male" {
            genderSegmentCtrl.selectedSegmentIndex = 0
        }else if userProfileData?.user_gender == "female" {
            genderSegmentCtrl.selectedSegmentIndex = 1
        }else if userProfileData?.user_gender == "Others" {
            genderSegmentCtrl.selectedSegmentIndex = 2
        }else {
            genderSegmentCtrl.selectedSegmentIndex = UISegmentedControl.noSegment
        }
    }
    
    private func showDatePicker() -> Void {
        datePicker.datePickerMode = .date
        
        let toolsBar = UIToolbar()
        toolsBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnTpd))
        let cancelBtn = UIBarButtonItem(title: "cancel", style: .plain, target: self, action: #selector(cancelBtnTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        //        toolsBar.items = [cancelBtn, doneBtn]
        toolsBar.setItems([cancelBtn, spaceButton, doneBtn], animated: false)
        
        dobTextFld.inputAccessoryView = toolsBar
        dobTextFld.inputView = datePicker
    }
    
    @objc func doneBtnTpd() -> Void {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        dobTextFld.text = formatter.string(from: datePicker.date)
        formatter.dateFormat = "yyyy-MM-dd"
        let selectedDate = formatter.string(from: datePicker.date as Date)
        userDob = selectedDate
        self.view.endEditing(true)
        
    }
    

    @objc func cancelBtnTapped() -> Void {
        self.view.endEditing(true)
    }
 
    private func validateAndSend() {
        let usersDob : String? = userDob
        if let firstName = firstNameTextFld.text, let dob = usersDob {
            if firstName.isEmpty || dob.isEmpty {
                self.showAlert(title: "Empty Fields", msg: "Please fill the fields")
            }else if firstName.isEmpty {
                self.showAlert(title: "First Name is Empty", msg: "Please fill the First Name")
            }else if dob.isEmpty {
                self.showAlert(title: "Date of Birth is Empty", msg: "Please fill the Date of Birth ")
            }else {
                let view = UserMobileNumberView.init(nibName: "UserMobileNumberView", bundle: nil)
                view.profileDate = userProfileData
                view.editedProfileData = userData(firstName, lastNameTextFld.text ?? "", gender, dob)
                self.navigationController?.pushViewController(view, animated: true)
            }
        }
    }
    
    private func showAlert(title : String, msg : String) {
        let loginAlert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        loginAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (okTpd) in
            
        }))
        self.present(loginAlert, animated: true, completion: nil)
    }
    
}

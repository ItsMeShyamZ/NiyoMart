//
//  UserMobileNumberView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 19/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class UserMobileNumberView: UIViewController {
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var mobNumSubmitButton: UIButton!
    @IBOutlet weak var verifyOTPBtn: UIButton!
    @IBOutlet weak var otpTxtFld: UITextField!
    @IBOutlet weak var reSendOTPBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    var profileDate : MyProfileStruct?
    var editedProfileData : userData?
    var otpData : OtpStruct?
    var submitTpd = false
    var verifyTpd = false
    var mobileNumVerified = false
    
    @IBAction func mobNumSubmitBtnTpd(_ sender: Any) {
        checkForMobNum()
    }
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func verifyOTPBtnTpd(_ sender: Any) {
        checkForOtp()
    }
    
    @IBAction func reSendOtpBtnTpd(_ sender: Any) {
        checkForMobNum()
    }
    
    @IBAction func cancelBtnTpd(_ sender: Any) {
        goBack()
    }
    
    @IBAction func saveBtnTpd(_ sender: Any) {
        saveUserDetails()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        loadUI()
    }
}

extension UserMobileNumberView {
    
    func loadUI() -> Void {
        print("editedProfileData : \(editedProfileData)")
        mobileNumberTextField.text = "\(profileDate?.user_phone ?? "")"
    }
    
    func checkForMobNum() {
        if let mobileNum = mobileNumberTextField.text {
            if mobileNum.isEmpty || mobileNum == "" {
                DispatchQueue.main.async {
                    self.showAlert(message: "Please Fill The Mobile Number")
                }
            }else {
                submitTpd = true
                self.sendOTP(mobileNum: mobileNum)
            }
        }else {
            DispatchQueue.main.async {
                self.showAlert(message: "Please Fill The Mobile Number")
            }
        }
    }
    
    func checkForOtp() {
        if let otp = otpTxtFld.text {
            if otp.isEmpty || otp == "" {
                DispatchQueue.main.async {
                    self.showAlert(message: "Please Fill The OTP Field")
                }
            }else {
                if otp.count == 6 {
                    verifyTpd = true
                    self.verifyOtpApi(otpCode: otp)
                }else {
                    DispatchQueue.main.async {
                        self.showAlert(message: "Please Fill The OTP Field")
                    }
                }
            }
        }else {
            DispatchQueue.main.async {
                self.showAlert(message: "Please Fill The Mobile Number")
            }
        }
    }
    
    
    private func sendOTP(mobileNum : String) {
        //        https://2factor.in/API/V1/{api_key}/SMS/+91{user's_phone_no}/AUTOGEN
        ApiManager.shared.sendOtpApi(mobileNum: mobileNum) { (otpResponseDetails, errorMsg) in
            print("otpResponseDetails : \(otpResponseDetails)")
            if errorMsg == "" {
                if otpResponseDetails.Status == "Success" {
                    self.otpData = otpResponseDetails
                    DispatchQueue.main.async {
                        self.showToast(message: "OTP Sent")
                    }
                }else {
                    print("otp sent failed")
                    DispatchQueue.main.async {
                        self.showAlert(message: "\(otpResponseDetails.Details ?? "Error Occured")")
                    }
                }
            }else {
                DispatchQueue.main.async {
                    self.showToast(message: errorMsg)
                }
            }
        }
    }
    
    private func verifyOtpApi(otpCode : String) {
         ApiManager.shared.verifyOtpApi(otp: otpCode, sessionId: otpData?.Details ?? "") { (otpResponseDetails, errorMsg) in
            print("otpResponseDetails : \(otpResponseDetails)")
             if errorMsg == "" {
                 if otpResponseDetails.Status == "Success" {
                    self.mobileNumVerified = true
                     DispatchQueue.main.async {
                        self.showToast(message: "OTP Verified")
                     }
                 }else {
                     DispatchQueue.main.async {
                        self.showToast(message: otpResponseDetails.Details ?? "Verification Failed")
                     }
                 }
             }else {
                 self.showToast(message: errorMsg)
             }
         }
     }
    
    func saveUserDetails() {
        if submitTpd {
            if verifyTpd {
                if mobileNumVerified {
                    saveUserprofileApi()
                }else {
                    showAlert(message: "Please verify your mobile number")
                }
            }else {
                showAlert(message: "Please verify your mobile number")
            }
        }else {
            saveUserprofileApi()
        }
    }
    
    func saveUserprofileApi() {
//        ApiManager.shared.saveUserProfileApi(firstName: editedProfileData?.0 ?? "", lastName: editedProfileData?.1 ?? "", gender: editedProfileData?.2 ?? "", dob: editedProfileData?.3 ?? "", userPhone: mobileNumberTextField.text ?? "")
        ApiManager.shared.saveUserProfileApi(firstName: editedProfileData?.0 ?? "", lastName: editedProfileData?.1 ?? "", gender: editedProfileData?.2 ?? "", dob: editedProfileData?.3 ?? "", userPhone: mobileNumberTextField.text ?? "") { (responseDetails) in
            if responseDetails.code == 200 {
                DispatchQueue.main.async {
                    self.goBack()
                }
            }else {
                self.showToast(message: responseDetails.result ?? "Failed")
            }
        }
    }
    
    private func goBack() {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    private func showAlert(message : String) {
         let loginAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
         loginAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (okTpd) in
             
         }))
         self.present(loginAlert, animated: true, completion: nil)
     }
}

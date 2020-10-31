//
//  OTPView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 24/08/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit
import OTPFieldView

class OTPView: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var issueButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var otpFieldView: OTPFieldView!
    
    
    var customView = OTPCustomView()
    var otpCode : String = ""
    var isFilled : Bool = false
    var mobileNumber = ""
    var otpData : OtpStruct?
    
    
    @IBAction func skipButtonTpd(_ sender: Any) {
        
    }
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func issueButtonTpd(_ sender: Any) {
        resendOTP()
    }
    
    @IBAction func verifyButtonTpd(_ sender: Any) {
        print("EnteredOtpCode : \(otpCode), isFilled : \(isFilled)")
        if isFilled {
           verifyOtpApi()
        }else {
            self.showToast(message: "Please fill all the fields")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOtpView()
    }
}

extension OTPView {
    
    func setupOtpView(){
        self.otpFieldView.fieldsCount = 6
        self.otpFieldView.fieldBorderWidth = 2
        self.otpFieldView.defaultBorderColor = UIColor.lightGray
        self.otpFieldView.filledBorderColor = UIColor.lightGray
        self.otpFieldView.cursorColor = UIColor.red
        self.otpFieldView.displayType = .underlinedBottom
        self.otpFieldView.fieldSize = 40
        self.otpFieldView.separatorSpace = 8
        self.otpFieldView.shouldAllowIntermediateEditing = false
        self.otpFieldView.delegate = self
        self.otpFieldView.initializeUI()
    }
    

    
    private func verifyOtpApi() {
        ApiManager.shared.verifyOtpApi(otp: otpCode, sessionId: otpData?.Details ?? "") { (otpResponseDetails, errorMsg) in
            if errorMsg == "" {
                if otpResponseDetails.Status == "Success" {
                    DispatchQueue.main.async {
                        self.signUpApiCall(loginId: self.mobileNumber)
                    }
                }else {
                    print("otp sent failed")
                }
            }else {
                self.showToast(message: errorMsg)
            }
        }
    }
    
    private func signUpApiCall(loginId : String) -> Void {
        ApiManager.shared.signUpApi(firstName: "", lastName: "", mobileNumber: loginId, password: "welcome") { (loginData, errorMsg) in
            if errorMsg == "" {
                if loginData.code == 200 {
//                    self.showAlert(message: "Success")
                    DispatchQueue.main.async {
                        self.loginApiCall(loginId :self.mobileNumber)
                    }
                }else if loginData.code == 206 {
                    //                    account exist
                    DispatchQueue.main.async {
                        self.loginApiCall(loginId :self.mobileNumber)
                    }
                }else if loginData.code == 400 {
                    //                    failed
                    DispatchQueue.main.async {
                        self.showAlert(message: "Sign Up failed")
                    }
                }
            }else {
                
            }
        }
    }
    
    private func loginApiCall(loginId : String) -> Void {
        showLoader(withTitle: "", and: "")
        
        ApiManager.shared.loginApi(loginId: loginId) { (loginData, errorMsg) in
            print("result : \(loginData.result ?? "")")
            if errorMsg.isEmpty || errorMsg == "" {
                if loginData.status?.isEmpty ?? false || loginData.status == nil {
                    //success
                    DispatchQueue.main.async {
                        //                        self.showToast(message: "Login Success")
                        self.goToLandingView()
                        setAutoLoginDetails(loginData: loginData)
                        self.hideLoader()
                    }
                }else {
                    if loginData.code == 200 {
                        //success
                        DispatchQueue.main.async {
                            //                        self.showToast(message: "Login Success")
                            self.goToLandingView()
                            setAutoLoginDetails(loginData: loginData)
                            self.hideLoader()
                        }
                    }else if loginData.code == 206 {
                        DispatchQueue.main.async {
                            //user name does not exist
                            self.hideLoader()
                            //                        self.showToast(message: "Mobile Number/e-mail Id doesn't exist")
                            self.showAlert(message: "Mobile Number/e-mail Id doesn't exist")
                        }
                    }else if loginData.code == 400 {
                        DispatchQueue.main.async {
                            //failed
                            self.hideLoader()
                            self.showAlert(message: "Sign In failed")
                        }
                    }else if loginData.code == 204 {
                        DispatchQueue.main.async {
                            //user name does not exist
                            self.hideLoader()
                            self.showAlert(message: "Mobile Number/e-mail Id doesn't exist")
                        }
                    }
                }
            }else {
                DispatchQueue.main.async {
                    self.hideLoader()
                }
                self.showToast(message: errorMsg)
            }

        }
    }
    
    func resendOTP() {
        ApiManager.shared.sendOtpApi(mobileNum: mobileNumber) { (otpResponseDetails, errorMsg) in
            if errorMsg == "" {
                if otpResponseDetails.Status == "Success" {
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
    
    private func showAlert(message : String) {
        let loginAlert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        loginAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (okTpd) in
            
        }))
        self.present(loginAlert, animated: true, completion: nil)
    }
    
    private func goToLandingView() {
         let view = HomePageView.init(nibName: "HomePageView", bundle: nil)
         self.navigationController?.pushViewController(view, animated: true)
     }
    
}

extension OTPView : OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        isFilled = hasEntered
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        print("OTPString: \(otpString)")
        otpCode = otpString
    }
}

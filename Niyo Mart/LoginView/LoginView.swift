//
//  LoginView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 11/07/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class LoginView: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeHintLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailIdtextField: UITextField!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    var loadFor = "signUp"
    var goForOtp = false

    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
//        loginApiCall(loginId: mobileNumberTextField.text ?? "")
    }
    
    
    
    
    @IBAction func loginButtonTpd(_ sender: Any) {
        if loadFor == "signUp" {
            loadFor = "signIn"
            loadUi()
        }else {
            
        }
    
    }
    
    @IBAction func signUpBtnTpd(_ sender: Any) {
        validateAndSend()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUi()
    }
}

extension LoginView {
    
    func loadUi() -> Void {
        
        if loadFor == "signUp" {
            
            welcomeLabel.text = "Welcome"
            welcomeHintLabel.text = "Sign Up to get started and experience great shop deals"
            signUpButton.setTitle("SIGN UP", for: .normal)
            loginButton.setTitle("Already have an account? SIGN IN", for: .normal)
            headerTitleLabel.text = "Sign Up"
        }else {
            goForOtp = false
            welcomeLabel.text = "Welcome Back"
            welcomeHintLabel.text = "Sign In to get started and experience great shop deals"
            signUpButton.setTitle("SIGN IN", for: .normal)
            loginButton.setTitle("Facing issue in sign In?", for: .normal)
            headerTitleLabel.text = "Sign In"
        }
    }
    
    private func validateAndSend() -> Void {
        
        if let emailId = emailIdtextField.text, let mobileNumber = mobileNumberTextField.text {
            
            let mailSet =
                CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ@._-0123456789 ")

            if emailId.isEmpty && mobileNumber.isEmpty {
                let emptyAlert = UIAlertController(title: "Field cannot be empty",
                                                   message: "Please Fill the Mobile Number or Email Field",
                                                   preferredStyle: .alert)
                   emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(saveBtnTpd) in
                   }))
                   self.present(emptyAlert, animated: true, completion: nil)
            }else if emailId.rangeOfCharacter(from: mailSet.inverted) != nil {
                let emptyAlert = UIAlertController(title: "Validation failed",
                                                message: "Special Character in Email Field",
                                                preferredStyle: .alert)
                emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(saveBtnTpd) in
                }))
                self.present(emptyAlert, animated: true, completion: nil)
            }else {
                if loadFor == "signUp" {
                    if emailId.isEmpty {
                        goForOtp = true
                        signUpApiCall(loginId: mobileNumber)
                    }else if mobileNumber.isEmpty {
                        goForOtp = false
                        signUpApiCall(loginId: emailId)
                    }else if !mobileNumber.isEmpty && !emailId.isEmpty {
                        goForOtp = true
                        signUpApiCall(loginId: mobileNumber)
                    }else {
                        let emptyAlert = UIAlertController(title: "Field cannot be empty",
                                                           message: "Please Fill the Mobile Number or Email Field",
                                                           preferredStyle: .alert)
                        emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(saveBtnTpd) in
                        }))
                        self.present(emptyAlert, animated: true, completion: nil)
                    }
                }else {
                    if emailId.isEmpty {
                        goForOtp = false
                        loginApiCall(loginId: mobileNumber)
                    }else if mobileNumber.isEmpty {
                        goForOtp = false
                        loginApiCall(loginId: emailId)
                    }else if !mobileNumber.isEmpty && !emailId.isEmpty {
                        goForOtp = false
                        loginApiCall(loginId: mobileNumber)
                    }else {
                        let emptyAlert = UIAlertController(title: "Field cannot be empty",
                                                           message: "Please Fill the Mobile Number or Email Field",
                                                           preferredStyle: .alert)
                        emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(saveBtnTpd) in
                        }))
                        self.present(emptyAlert, animated: true, completion: nil)
                    }
                }
            }
        }else {
            let emptyAlert = UIAlertController(title: "Field cannot be empty",
                                               message: "Please Fill the Mobile Number or Email Field",
                                               preferredStyle: .alert)
            emptyAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(saveBtnTpd) in
            }))
            self.present(emptyAlert, animated: true, completion: nil)
        }
    }
    
    private func signUpApiCall(loginId : String) -> Void {
        emailIdtextField.resignFirstResponder()
        mobileNumberTextField.resignFirstResponder()
        if goForOtp {
            self.sendOTP(mobileNum: loginId)
        }else {
            ApiManager.shared.signUpApi(firstName: "", lastName: "", mobileNumber: loginId, password: "welcome") { (loginData, errorMsg) in
                if errorMsg == "" {
                    if loginData.code == 200 {
                        DispatchQueue.main.async {
//                            if self.goForOtp {
                                //                            let view = OTPView.init(nibName: "OTPView", bundle: nil)
                                //                            self.navigationController?.pushViewController(view, animated: false)
//                                self.sendOTP(mobileNum: loginId)
//                            }else {
                                //                            self.goToLandingView()
                                //                            setAutoLoginDetails(loginData: loginId)
                                self.loginApiCall(loginId: loginId)
//                            }
                        }
                    }else if loginData.code == 206 {
                        //                    account exist
                        DispatchQueue.main.async {
                            //                        self.goToLandingView()
                            self.showAlert(message: "Account Exists! \n Please Sign-In and Continue")
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

    }
    
    private func loginApiCall(loginId : String) -> Void {
        showLoader(withTitle: "", and: "")
        emailIdtextField.resignFirstResponder()
        mobileNumberTextField.resignFirstResponder()
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
    
    private func sendOTP(mobileNum : String) {
//        https://2factor.in/API/V1/{api_key}/SMS/+91{user's_phone_no}/AUTOGEN
        ApiManager.shared.sendOtpApi(mobileNum: mobileNum) { (otpResponseDetails, errorMsg) in
            if errorMsg == "" {
                if otpResponseDetails.Status == "Success" {
                    DispatchQueue.main.async {
                        let view = OTPView.init(nibName: "OTPView", bundle: nil)
                        view.mobileNumber = mobileNum
                        view.otpData = otpResponseDetails
                        self.navigationController?.pushViewController(view, animated: false)
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
    
}


func setAutoLoginDetails(loginData : LogInStruct) {
    if let userId = loginData.user_id, let loginId = loginData.login_name {
        UserDefaults.standard.set(true, forKey: "login")
        UserDefaults.standard.set(loginId, forKey: "userName")
        DataLoad.shared.setUserName = loginId
        DataLoad.shared.setUserId = "\(userId)"
    }else {
        UserDefaults.standard.set(false, forKey: "login")
    }
}

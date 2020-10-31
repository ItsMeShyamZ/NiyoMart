//
//  GetStartedView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 22/08/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift


class GetStartedView: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var adImgView: UIImageView!
    @IBOutlet weak var blurImgView: UIImageView!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var welcomeHintLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func skipButtonTpd(_ sender: Any) {
        let view = HomePageView.init(nibName: "HomePageView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func signInButton(_ sender: Any) {
        let view = LoginView.init(nibName: "LoginView", bundle: nil)
        view.loadFor = "signIn"
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    @IBAction func signUpButtonTpd(_ sender: Any) {
        let view = LoginView.init(nibName: "LoginView", bundle: nil)
        view.loadFor = "signUp"
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}



extension UIViewController {
    
    func showLoader(withTitle title: String, and Description:String) {
        
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = title
        self.view.isUserInteractionEnabled = false
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = Description
        Indicator.show(animated: true)
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.isUserInteractionEnabled = true
        }
        
    }
    
    func showToast(message : String) {
        DispatchQueue.main.async {
            var style = ToastStyle()
            style.messageColor = .white
            ToastManager.shared.style = style
            self.view.makeToast(message, duration: 3.0, position: .bottom)
//            self.view.makeToastActivity(.bottom)
            ToastManager.shared.isTapToDismissEnabled = true

            ToastManager.shared.isQueueEnabled = true
        }
    }
}

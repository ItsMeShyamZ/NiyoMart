//
//  WelcomeView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 22/08/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class WelcomeView: UIViewController {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var getStartedBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBAction func getStartBtnTpd(_ sender: Any) {
        let view = GetStartedView.init(nibName: "GetStartedView", bundle: nil)
//        let view = ProfileOptionsView.init(nibName: "ProfileOptionsView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    @IBAction func signInBtnTpd(_ sender: Any) {
        let view = LoginView.init(nibName: "LoginView", bundle: nil)
        view.loadFor = "signIn"
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension WelcomeView {
    
}

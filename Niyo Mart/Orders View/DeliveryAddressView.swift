//
//  DeliveryAddressView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 26/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class DeliveryAddressView: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBAction func backBtnTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextBtnTpd(_ sender: Any) {
        let view = PaymentCheckView.init(nibName: "PaymentCheckView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

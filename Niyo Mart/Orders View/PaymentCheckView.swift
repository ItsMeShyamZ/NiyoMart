//
//  PaymentCheckView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 26/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class PaymentCheckView: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextBtnTpd(_ sender: Any) {
        let view = OrderSummaryView.init(nibName: "OrderSummaryView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

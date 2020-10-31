//
//  NiyoMartContactView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 17/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class NiyoMartContactView: UIViewController {
    
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()

    }

}

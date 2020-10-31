//
//  MenuHeaderView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 26/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class MenuHeaderView: UICollectionReusableView {

    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderColor = UIColor(named: "appColor")?.cgColor
    }
    
}

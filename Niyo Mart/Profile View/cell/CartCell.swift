//
//  CartCell.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 17/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var qtyView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    
    @IBAction func deleteBtnTpd(_ sender: Any) {
    }
    
    @IBAction func addBtnTpd(_ sender: Any) {
    }
    
    @IBAction func removeBtnTpd(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productImageView.layer.borderWidth = 0.5
        productImageView.layer.borderColor = UIColor.lightGray.cgColor
        productImageView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataAndIcons(callFor : String) -> Void {
        if callFor == "tracking" {
            qtyView.isHidden = true
            deleteBtn.isHidden = true
            quantityLabel.isHidden = false
        }else {
            qtyView.isHidden = false
            deleteBtn.isHidden = false
            quantityLabel.isHidden = true
        }
    }
    
}

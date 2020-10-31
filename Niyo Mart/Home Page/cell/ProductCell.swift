//
//  ProductCell.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 25/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var offerlabel: UILabel!
    @IBOutlet weak var offtitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var qtyAddBtn: UIButton!
    @IBOutlet weak var qtyView: UIView!
    @IBOutlet weak var qtyRemBtn: UIButton!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var mrpLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    @IBAction func addButtonTpd(_ sender: Any) {
    
    }
    
    @IBAction func qtyAddBtnTpd(_ sender: Any) {
        
    }
    
    @IBAction func qtyRemoveBtnTpd(_ sender: Any) {
    
    }
    
    @IBAction func deleteBtnTpd(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

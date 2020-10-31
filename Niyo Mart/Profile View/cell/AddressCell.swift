//
//  AddressCell.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 20/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

protocol addressCellDelegate : NSObjectProtocol {
    func defaultBtnTpd(clickedCell : AddressCell)
}

class AddressCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var defaultButton: UIButton!
    
    var delegate : addressCellDelegate?
    
    @IBAction func defaultBtnTpd(_ sender: Any) {
        delegate?.defaultBtnTpd(clickedCell: self)
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

extension AddressCell {
    func loadAddress(addressData : UserAddressStruct) {
        if let id = addressData.id {
            addressLabel.text = "\(addressData.street1 ?? ""), \(addressData.street2 ?? ""), \(addressData.city ?? ""), \(addressData.district ?? ""), \n\(addressData.state ?? ""), Pincode - \(addressData.pincode ?? "-") \nLandmark : \(addressData.landmark ?? "-")"
            if addressData.default_flag == "Y" {
                defaultButton.backgroundColor = UIColor(named: "appColor")
                defaultButton.titleLabel?.textColor = UIColor(named: "bgViewColor")
//                defaultButton.layer.backgroundColor = UIColor.white.cgColor
                defaultButton.layer.cornerRadius = 0
            }else {
                defaultButton.backgroundColor = UIColor.white
                defaultButton.setTitleColor(UIColor(named: "appColor"), for: .normal)
                defaultButton.layer.cornerRadius = 1
                defaultButton.layer.borderWidth = 0.5
                defaultButton.layer.borderColor = UIColor(named: "appColor")?.cgColor
            }
        }
    }
}

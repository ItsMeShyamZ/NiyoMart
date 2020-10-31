//
//  TrackOrderView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 24/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class TrackOrderView: UIViewController {
    
    @IBOutlet weak var centerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var footerBtn: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var productDetaillabel: UILabel!
    @IBOutlet weak var productImgView: UIImageView!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var trackView: UIView!
    @IBOutlet weak var track1ImgView: UIImageView!
    @IBOutlet weak var track1DateLabel: UILabel!
    @IBOutlet weak var track1TypeLabel: UILabel!
    @IBOutlet weak var track2ImgView: UIImageView!
    @IBOutlet weak var track2DateLabel: UILabel!
    @IBOutlet weak var track2TypeLabel: UILabel!
    @IBOutlet weak var track3DateLabel: UILabel!
    @IBOutlet weak var track3TypeLabel: UILabel!
    @IBOutlet weak var track3ImgView: UIImageView!
    @IBOutlet weak var track4DateLabel: UILabel!
    @IBOutlet weak var track4TypeLabel: UILabel!
    @IBOutlet weak var track4ImgView: UIImageView!

    
    
    
    
    @IBAction func footerBtnTpd(_ sender: Any) {
    }
    
    
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            loadUi()
    }
}

extension TrackOrderView {
    
    private func loadUi() -> Void {
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        
    }
    
}


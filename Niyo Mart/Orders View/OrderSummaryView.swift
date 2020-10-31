//
//  OrderSummaryView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 26/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class OrderSummaryView: UIViewController {
    

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    
    
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func nextBtnTpd(_ sender: Any) {
        let view = HomePageView.init(nibName: "HomePageView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        productCollectionView.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
    }

}

extension OrderSummaryView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfItemsPerRow:CGFloat = 3
//        let spacingBetweenCells:CGFloat = 1
//
//        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
//
//        if let collection = self.categoryCollectionView{
//            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
//            return CGSize(width: width, height: width)
//        }else{
//            return CGSize(width: 0, height: 0)
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MenuCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! MenuCell
        cell.imgView.image = UIImage(named: "niyoMart1024.png")
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let view = ProductListView.init(nibName: "ProductListView", bundle: nil)
//        self.navigationController?.pushViewController(view, animated: false)
//
//    }
    
}

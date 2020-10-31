//
//  UXTableView.swift
//  Gron
//
//  Created by Abservetech on 04/03/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView{
    func registerCell(withId id : cellID){
        self.register(UINib(nibName: id.rawValue, bundle: Bundle.main), forCellWithReuseIdentifier: id.rawValue)
       }
       
}

extension UITableView{
    
   
        func setBottomInset(to value: CGFloat) {
            let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

            self.contentInset = edgeInset
            self.scrollIndicatorInsets = edgeInset
        }
  
    
    func registerCell(withId id : cellID){
        self.register(UINib(nibName: id.rawValue, bundle: Bundle.main), forCellReuseIdentifier: id.rawValue)
    }
    
            
        func animateTable() {
            self.reloadData()
            
            let cells = self.visibleCells
            let tableHeight: CGFloat = self.bounds.size.height
            
            for i in cells {
                let cell: UITableViewCell = i as UITableViewCell
                cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            }
            
            var index = 0
            
            for a in cells {
                let cell: UITableViewCell = a as UITableViewCell
                UIView.animate(withDuration: 1, delay: 0.05 * Double(index), usingSpringWithDamping: 1, initialSpringVelocity: 0, animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
                index += 1
            }
    }

    
}

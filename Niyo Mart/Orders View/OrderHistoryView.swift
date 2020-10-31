//
//  OrderHistoryView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 17/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class OrderHistoryView: UIViewController {
    
    
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    var callFor = "history"
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         historyTableView.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "productCell")
        loadUi()
    }
}

extension OrderHistoryView {
    
    private func loadUi() -> Void {
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        if callFor == "tracking" {
            headerTitleLabel.text = "Track Order"
        }else {
            headerTitleLabel.text = "Order History"
        }
    }
    
}

extension OrderHistoryView : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CartCell = historyTableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! CartCell
        cell.setDataAndIcons(callFor: callFor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        historyTableView.deselectRow(at: indexPath, animated: false)
        if callFor == "tracking" {
            let view = TrackOrderView.init(nibName: "TrackOrderView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    
}

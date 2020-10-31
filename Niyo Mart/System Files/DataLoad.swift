//
//  DataLoad.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 21/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class DataLoad: NSObject {

    static let shared = DataLoad()
    
    
    var setUserName = ""
    var setPassword = ""
    var setUserId = ""
    
    func getUserName() -> String {
        return setUserName
    }
    
    func getUserId() -> String {
        return setUserId
    }
}

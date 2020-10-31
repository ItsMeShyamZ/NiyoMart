//
//  UtilCollections.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 22/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift

class UtilCollections: NSObject {
    
    static let shared = UtilCollections()
    
    var setReload = false

    
    func getHeaderTitleFont() -> UIFont {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIFont.systemFont(ofSize: 17, weight: .medium)
        }else if UIDevice.current.userInterfaceIdiom == .pad {
            return UIFont.systemFont(ofSize: 20, weight: .medium)
        }else {
             return UIFont.systemFont(ofSize: 17, weight: .medium)
        }
    }
    
    func getTitleTextFont() -> UIFont {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIFont.systemFont(ofSize: 18, weight: .semibold)
        }else if UIDevice.current.userInterfaceIdiom == .pad {
            return UIFont.systemFont(ofSize: 21, weight: .semibold)
        }else {
            return UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
    }
    
    func getTextFont() -> UIFont {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        }else if UIDevice.current.userInterfaceIdiom == .pad {
            return UIFont.systemFont(ofSize: 18, weight: .regular)
        }else {
            return UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
    
//    func getHeaderTextFont() -> UIFont {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return UIFont.systemFont(ofSize: 16, weight: .medium)
//        }else if UIDevice.current.userInterfaceIdiom == .pad {
//            return UIFont.systemFont(ofSize: 19, weight: .medium)
//        }else {
//            return UIFont.systemFont(ofSize: 16, weight: .medium)
//        }
//    }
    
    func getDoneTextFont() -> UIFont {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIFont.systemFont(ofSize: 18, weight: .bold)
        }else if UIDevice.current.userInterfaceIdiom == .pad {
            return UIFont.systemFont(ofSize: 21, weight: .bold)
        }else {
            return UIFont.systemFont(ofSize: 18, weight: .bold)
        }
    }

    func getReloadView() -> Bool {
        return setReload
    }
    
}

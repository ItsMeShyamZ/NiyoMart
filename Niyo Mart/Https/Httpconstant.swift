//
//  Httpconstant.swift
//  D911 Agency
//
//  Created by Abservetech on 05/02/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation

struct Api {
    static let baseURL = "www.niyomart.com/api/"
    static let settingURL = "https://www.gronride.com:3001/"
    static let ImgURL = "https://www.gronride.com:3001/"
    static let socketURL = "https://www.gronride.com:3001/"
    
//    https://colleaguepool.com:3005/
    struct Support {
        static var supportURL = "supportcatg"
    }
    struct Accout {
        static let login = "login"
        static let sentotp = "sentotp"
        static let userProfile = "userProfile"
    }
    struct category {
        static let categoryList = "category"
    }
    
    struct google {
        static let nearbySearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?"
        static let directions = "https://maps.googleapis.com/maps/api/directions/json?"
    }
}


struct HttpError{
    static let noInternet = "Please check your internet connection"
    static let apiConnection = "Check api Method, network connetion , this error from app side only"
    static let serverError = "Api server Error , Check with backend Geeks"
    static let somthingWentWrong = "SomeThing Went Wrong"
}


extension Int{
    func isResponseOK() -> Bool{
        return (200...299).contains(self)
    }
}

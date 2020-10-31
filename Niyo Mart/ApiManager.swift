//
//  ApiManager.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 15/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit
import Toast_Swift


struct SignUpStruct : Codable {
    var code : Int?
    var result : String?
    var status : String?
    
    enum signUpCodingKey : String, CodingKey {
        case code = "code"
        case result = "result"
        case status = "status"
    }
    
    init(from signUpDecoder : Decoder) throws {
        let signUpDecodervalue = try signUpDecoder.container(keyedBy: signUpCodingKey.self)
        code = try signUpDecodervalue.decodeIfPresent(Int.self, forKey: .code)
        result = try signUpDecodervalue.decodeIfPresent(String.self, forKey: .result)
        status = try signUpDecodervalue.decodeIfPresent(String.self, forKey: .status)
    }
}

struct ApiResponseStruct : Codable {
    var code : Int?
    var result : String?
    var status : String?
    var insertId : String?
    
    enum signUpCodingKey : String, CodingKey {
        case code = "code"
        case result = "result"
        case status = "status"
        case insertId = "insertId"
    }
    
    init(from signUpDecoder : Decoder) throws {
        let signUpDecodervalue = try signUpDecoder.container(keyedBy: signUpCodingKey.self)
        code = try signUpDecodervalue.decodeIfPresent(Int.self, forKey: .code)
        result = try signUpDecodervalue.decodeIfPresent(String.self, forKey: .result)
        status = try signUpDecodervalue.decodeIfPresent(String.self, forKey: .status)
        insertId = try signUpDecodervalue.decodeIfPresent(String.self, forKey: .insertId)
        
    }
}

struct LogInStruct : Codable {
    var user_id : Int?
    var first_name : String?
    var last_name : String?
    var login_name : String?
    var user_email : String?
    var user_phone : String?
    var user_image : String?
    var user_gender : String?
    var user_dob : String?
    var code : Int?
    var result : String?
    var status : String?
    
    enum logInCodingKey : String, CodingKey {
        case code = "code"
        case result = "result"
        case status = "status"
        case user_id = "user_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case login_name = "login_name"
        case user_email = "user_email"
        case user_phone = "user_phone"
        case user_image = "user_image"
        case user_gender = "user_gender"
        case user_dob = "user_dob"
    }
    
    init(user_id : Int, login_name : String) {
        self.user_id = user_id
        self.login_name = login_name
    }
    
    init(from logInDecoder : Decoder) throws {
        let logInDecodervalue = try logInDecoder.container(keyedBy: logInCodingKey.self)
        code = try logInDecodervalue.decodeIfPresent(Int.self, forKey: .code)
        result = try logInDecodervalue.decodeIfPresent(String.self, forKey: .result)
        status = try logInDecodervalue.decodeIfPresent(String.self, forKey: .status)
        user_id = try logInDecodervalue.decodeIfPresent(Int.self, forKey: .user_id)
        first_name = try logInDecodervalue.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try logInDecodervalue.decodeIfPresent(String.self, forKey: .last_name)
        login_name = try logInDecodervalue.decodeIfPresent(String.self, forKey: .login_name)
        user_email = try logInDecodervalue.decodeIfPresent(String.self, forKey: .user_email)
        user_phone = try logInDecodervalue.decodeIfPresent(String.self, forKey: .user_phone)
        user_image = try logInDecodervalue.decodeIfPresent(String.self, forKey: .user_image)
        user_gender = try logInDecodervalue.decodeIfPresent(String.self, forKey: .user_gender)
        user_dob = try logInDecodervalue.decodeIfPresent(String.self, forKey: .user_dob)
    }
}

struct MyProfileStruct : Codable {
    var user_id : Int?
    var first_name : String?
    var last_name : String?
    var login_name : String?
    var user_email : String?
    var user_phone : String?
    var user_image : String?
    var user_gender : String?
    var user_dob : String?
    
    enum MyProfileCodingKey : String, CodingKey {
        case user_id = "user_id"
        case first_name = "first_name"
        case last_name = "last_name"
        case login_name = "login_name"
        case user_email = "user_email"
        case user_phone = "user_phone"
        case user_image = "user_image"
        case user_gender = "user_gender"
        case user_dob = "user_dob"
    }
    
    
    init(from myProfileDecoder : Decoder) throws {
        let myProfileDecoderValue = try myProfileDecoder.container(keyedBy: MyProfileCodingKey.self)
        user_id = try myProfileDecoderValue.decodeIfPresent(Int.self, forKey: .user_id)
        first_name = try myProfileDecoderValue.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try myProfileDecoderValue.decodeIfPresent(String.self, forKey: .last_name)
        login_name = try myProfileDecoderValue.decodeIfPresent(String.self, forKey: .login_name)
        user_email = try myProfileDecoderValue.decodeIfPresent(String.self, forKey: .user_email)
        user_phone = try myProfileDecoderValue.decodeIfPresent(String.self, forKey: .user_phone)
        user_image = try myProfileDecoderValue.decodeIfPresent(String.self, forKey: .user_image)
        user_gender = try myProfileDecoderValue.decodeIfPresent(String.self, forKey: .user_gender)
        user_dob = try myProfileDecoderValue.decodeIfPresent(String.self, forKey: .user_dob)
        
    }
    //    {
    //       "street1": "GS Nagar",
    //       "street2": "Harur",
    //       "city": "Dharmapuri",
    //       "district": "Dharmapuri",
    //       "state": "Tamil Nadu",
    //       "landmark": "KVB Bank",
    //       "pincode": "636903"
    //    }
    
}

//{ "Status": "Success", "Details": "5D6EBEE6-EC04-4776-846D"}

struct OtpStruct : Codable {
    var Status : String?
    var Details : String?
    
    enum OtpCodingKey : String, CodingKey {
        case Status = "Status"
        case Details = "Details"
    }
    
    init(from OtpDecoder : Decoder) throws {
        let otpDecodervalue = try OtpDecoder.container(keyedBy: OtpCodingKey.self)
        Details = try otpDecodervalue.decodeIfPresent(String.self, forKey: .Details)
        Status = try otpDecodervalue.decodeIfPresent(String.self, forKey: .Status)
    }
    
}

struct UserAddressStruct : Codable {
    var id : Int?
    var street1 : String?
    var street2 : String?
    var city : String?
    var district : String?
    var state : String?
    var landmark : String?
    var pincode : String?
    var default_flag : String?
    
    enum userAddressCodingKey : String, CodingKey {
        case id = "id"
        case street1 = "street1"
        case street2 = "street2"
        case city = "city"
        case district = "district"
        case state = "state"
        case landmark = "landmark"
        case pincode = "pincode"
        case default_flag = "default_flag"
    }
    
    init(from userAddressDecoder : Decoder) throws {
        let userAddressDecoderValue = try userAddressDecoder.container(keyedBy: userAddressCodingKey.self)
        id = try userAddressDecoderValue.decodeIfPresent(Int.self, forKey: .id)
        street1 = try userAddressDecoderValue.decodeIfPresent(String.self, forKey: .street1)
        street2 = try userAddressDecoderValue.decodeIfPresent(String.self, forKey: .street2)
        city = try userAddressDecoderValue.decodeIfPresent(String.self, forKey: .city)
        district = try userAddressDecoderValue.decodeIfPresent(String.self, forKey: .district)
        state = try userAddressDecoderValue.decodeIfPresent(String.self, forKey: .state)
        landmark = try userAddressDecoderValue.decodeIfPresent(String.self, forKey: .landmark)
        pincode = try userAddressDecoderValue.decodeIfPresent(String.self, forKey: .pincode)
        default_flag = try userAddressDecoderValue.decodeIfPresent(String.self, forKey: .default_flag)
        
    }
}

class ApiManager: NSObject {
    
    static let shared = ApiManager()
    
    
    func signUpApi(firstName : String, lastName : String, mobileNumber : String, password : String, completionHandler : @escaping(_ loginData : SignUpStruct,_ errorMessage : String) -> Void) {
        
        let parmaetrs = ["first_name":"\(firstName)",
            "last_name" : "\(lastName)",
            "login_id" : "\(mobileNumber)",
            "password" : "\(password)"]
        
        let loginApi = URL(string: "http://www.niyomart.com/api/register/")
        var request = URLRequest(url: loginApi!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parmaetrs, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("registerApi : \(loginApi!)",parmaetrs)
        
        URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
            guard let urlData = jsonData else {
                return
            }
            print("jsonData : \(jsonData)")
            do {
                let loginData = try JSONDecoder().decode(SignUpStruct.self, from: urlData)
                completionHandler(loginData, "")
                print("loginData : \(loginData)")
            }catch let error as NSError {
                print("Login Api- \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    func loginApi(loginId : String, completionHandler : @escaping(_ loginData : LogInStruct,_ errorMessage : String) -> Void) {
        //        www.niyomart.com/api/login/
        //        {
        //           "loginname": "9008006001",
        //           "password": "welcome"
        //        }
        
        let parameters = [
            "loginname": "\(loginId)",
            "password": "welcome"
        ]
        let loginApi = URL(string: "https://www.niyomart.com/api/login/")
        var request = URLRequest(url: loginApi!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("loginApi : \(loginApi!), parameters : \(parameters)")
        
        URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
            guard let urlData = jsonData else {
                return
            }
            let emptyData = LogInStruct(user_id: 0, login_name: "")
            do {
                let loginData = try JSONDecoder().decode(LogInStruct.self, from: urlData)
                completionHandler(loginData, "")
                print("loginData : \(loginData)")
            }catch let error as NSError {
                print("Login Api- \(error.localizedDescription)")
                completionHandler(emptyData, "\(error.localizedDescription)")
                
            }
        }.resume()
    }
    
    
    func sendOtpApi(mobileNum : String, completionHandler : @escaping(_ isSent : OtpStruct, _ errorMessage : String) -> Void) {
        //        https://2factor.in/API/V1/{api_key}/SMS/+91{user's_phone_no}/AUTOGEN
        let url = "https://2factor.in/API/V1/9dfc9a31-f8a6-11ea-9fa5-0200cd936042/SMS/+91\(mobileNum)/AUTOGEN"
        if let sendOtpApi = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) {
            print("insertAccountApi : \(sendOtpApi)")
            
            URLSession.shared.dataTask(with: sendOtpApi) { (jsonData, jsonResponse, jsonErrorStatus) in
                
                guard let urlData = jsonData else {
                    return
                }
                
                if jsonErrorStatus == nil {
                    do {
                        let otpData = try JSONDecoder().decode(OtpStruct.self, from: urlData)
                        print("apiResponse : \(otpData.Status ?? "")")
                        completionHandler(otpData, "")
                    }catch let error as NSError {
                        print("verifyOtpApi - \(error.localizedDescription)")
                        
                    }
                    
                }else {
                    
                }
            }.resume()
            
        }else {
            
        }
    }
    
    
    func verifyOtpApi(otp : String, sessionId : String, completionHandler : @escaping(_ isSent : OtpStruct, _ errorMessage : String) -> Void) {
        //https://2factor.in/API/V1/{api_key}/SMS/VERIFY/{session_id}/{otp_entered_by_user}
        let url = "https://2factor.in/API/V1/9dfc9a31-f8a6-11ea-9fa5-0200cd936042/SMS/VERIFY/\(sessionId)/\(otp)"
        if let sendOtpApi = URL(string: url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!) {
            print("insertAccountApi : \(sendOtpApi)")
            
            URLSession.shared.dataTask(with: sendOtpApi) { (jsonData, jsonResponse, jsonErrorStatus) in
                
                guard let urlData = jsonData else {
                    return
                }
                
                if jsonErrorStatus == nil {
                    do {
                        let otpData = try JSONDecoder().decode(OtpStruct.self, from: urlData)
                        print("apiResponse : \(otpData.Status ?? "")")
                        completionHandler(otpData, "")
                    }catch let error as NSError {
                        print("verifyOtpApi - \(error.localizedDescription)")
                    }
                }else {
                    
                }
            }.resume()
            
        }else {
            
        }
    }
    
    func getProfileDetailsApi(completionHandler : @escaping(_ loginData : MyProfileStruct) -> Void) {
        
        let userApi = URL(string: "http://www.niyomart.com/api/user/\(DataLoad.shared.getUserId())")
        var request = URLRequest(url: userApi!)
        request.httpMethod = "GET"
        //        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("userApi : \(userApi!)")
        URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
            guard let urlData = jsonData else {
                return
            }
            
            do {
                let loginUserData = try JSONDecoder().decode(MyProfileStruct.self, from: urlData)
                completionHandler(loginUserData)
                print("loginUserData : \(loginUserData)")
            }catch let error as NSError {
                print("Profile Api- \(error.localizedDescription)")
            }
        }.resume()
        
    }
    
    func saveUserProfileApi(firstName : String, lastName : String?, gender : String, dob : String, userPhone : String?, completionHandler : @escaping(_ loginData : SignUpStruct) -> Void) {
        //        API : www.niyomart.com/api/user/1
        //        Request Method: PUT
        //        Content-Type: application/json
        let parameters = [
            "first_name": firstName,
            "last_name": lastName ?? "",
            "user_gender": gender,
            "user_dob": dob,
            "user_phone" : userPhone ?? ""
        ]
        let userApi = URL(string: "http://www.niyomart.com/api/user/\(DataLoad.shared.getUserId())")
        var request = URLRequest(url: userApi!)
        request.httpMethod = "PUT"
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        print("userApi : \(userApi!)")
        URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
            guard let urlData = jsonData else {
                return
            }
            
            do {
                let responseData = try JSONDecoder().decode(SignUpStruct.self, from: urlData)
                completionHandler(responseData)
                print("responseData : \(responseData)")
            }catch let error as NSError {
                print("saveUserProfile Api- \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    func fetchUserAddressApi(completionHandler : @escaping(_ userAddressData : [UserAddressStruct], _ erroeMsg : String) -> Void) -> Void {
        //        API : www.niyomart.com/api/user/address/1
        //        Request Method: GET
        //        Content-Type: application/json
        
        if let userApi = URL(string: "http://www.niyomart.com/api/user/address/\(DataLoad.shared.getUserId())") {
            var request = URLRequest(url: userApi)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print("userApi : \(userApi)")
            URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
                guard let urlData = jsonData else {
                    return
                }
                
                do {
                    let userAddressData = try JSONDecoder().decode([UserAddressStruct].self, from: urlData)
                    completionHandler(userAddressData, "")
                    print("userAddressData : \(userAddressData)")
                }catch let error as NSError {
                    completionHandler([], "\(error.localizedDescription)")
                    print("fetchUserAddress Api- \(error.localizedDescription)")
                }
            }.resume()
        }else {
            completionHandler([], "")
        }
    }
    
    
    func addAddressApi(street1 : String?, street2 : String?, city : String, district : String, state : String, landMark : String, pincode : String, completionHandler : @escaping(_ loginData : ApiResponseStruct) -> Void) {
        //        API : www.niyomart.com/api/user/address/1
        //        Request Method: POST
        //        Content-Type: application/json
        let parameters = [
            "street1": street1 ?? "",
            "street2": street2 ?? "",
            "city": city,
            "district": district,
            "state" : state,
            "landmark" : landMark,
            "pincode" : pincode
        ]
        if let addAddressApi = URL(string: "https://www.niyomart.com/api/user/address/\(DataLoad.shared.getUserId())") {
            var request = URLRequest(url: addAddressApi)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print("addAddressApi : \(addAddressApi)")
            URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
                guard let urlData = jsonData else {
                    return
                }
                
                do {
                    let responseData = try JSONDecoder().decode(ApiResponseStruct.self, from: urlData)
                    completionHandler(responseData)
                    print("responseData : \(responseData)")
                }catch let error as NSError {
                    print("addAddress Api- \(error.localizedDescription)")
                }
            }.resume()
        }else {
            
        }
        
    }
    
    func updateAddressApi(street1 : String?, street2 : String?, city : String, district : String, state : String, landMark : String, pincode : String, completionHandler : @escaping(_ loginData : SignUpStruct) -> Void) {
        //        API : www.niyomart.com/api/user/address/1
        //        Request Method: POST
        //        Content-Type: application/json
        let parameters = [
            "street1": street1 ?? "",
            "street2": street2 ?? "",
            "city": city,
            "district": district,
            "state" : state,
            "landmark" : landMark,
            "pincode" : pincode
        ]
        if let updateAddressApi = URL(string: "https://www.niyomart.com/api/user/address/\(DataLoad.shared.getUserId())") {
            var request = URLRequest(url: updateAddressApi)
            request.httpMethod = "PUT"
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print("updateAddressApi : \(updateAddressApi), parameters : \(parameters)")
            URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
                guard let urlData = jsonData else {
                    return
                }
                
                do {
                    let responseData = try JSONDecoder().decode(SignUpStruct.self, from: urlData)
                    completionHandler(responseData)
                    print("responseData : \(responseData)")
                }catch let error as NSError {
                    print("addAddress Api- \(error.localizedDescription)")
                }
            }.resume()
        }else {
            
        }
    }
    
    
    func deleteUserAddressApi(addressId : String, completionHandler : @escaping(_ deletedData : SignUpStruct) -> Void) {
//        API : www.niyomart.com/api/user/address/4
//        Request Method: DELETE
//        Content-Type: application/json
        
        if let deleteApi = URL(string: "https://www.niyomart.com/api/user/address/\(addressId)") {
            var request = URLRequest(url: deleteApi)
            request.httpMethod = "DELETE"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            print("deleteApi : \(deleteApi)")
            
            URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
                guard let urlData = jsonData else {
                    return
                }
                
                do {
                    let responseData = try JSONDecoder().decode(SignUpStruct.self, from: urlData)
                    completionHandler(responseData)
                    print("responseData : \(responseData)")
                }catch let error as NSError {
                    print("deleteUserAddress Api- \(error.localizedDescription)")
                }
            }.resume()
            
        }else {
            print("Empty Data in delete API")
        }
    }

    func setToDefaultAddressApi(addressId : String, completionHandler : @escaping(_ deletedData : SignUpStruct) -> Void) {
        //        API : www.niyomart.com/api/user/address/1/4
        //        Request Method: PUT
        //        Content-Type: application/json
        
        if let defaultAddressApi = URL(string: "https://www.niyomart.com/api/user/address/\(DataLoad.shared.getUserId())/\(addressId)") {
            var request = URLRequest(url: defaultAddressApi)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print("defaultAddressApi : \(defaultAddressApi)")
            URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
                guard let urlData = jsonData else {
                    return
                }
                
                do {
                    let responseData = try JSONDecoder().decode(SignUpStruct.self, from: urlData)
                    completionHandler(responseData)
                    print("responseData : \(responseData)")
                }catch let error as NSError {
                    print("defaultAddressApi- \(error.localizedDescription)")
                }
            }.resume()
        }
        
    }
    
    func fetchCategory(completionHandler : @escaping(_ userAddressData : [CategoryModel], _ erroeMsg : String) -> Void) -> Void {
        //        API : http://www.niyomart.com/api/category
        //        Request Method: GET
        //        Content-Type: application/json
        
        if let userApi = URL(string: "http://www.niyomart.com/api/category)") {
            var request = URLRequest(url: userApi)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            print("userApi : \(userApi)")
            URLSession.shared.dataTask(with: request) { (jsonData, jsonResponse, jsonErrorStatus) in
                guard let urlData = jsonData else {
                    return
                }
                print("jsonData : \(jsonData) \(jsonResponse)")
                do {
                    let userAddressData = try JSONDecoder().decode([CategoryModel].self, from: urlData)
                    completionHandler(userAddressData, "")
                    print("fetchCategory : \(userAddressData)")
                }catch let error as NSError {
                    completionHandler([], "\(error.localizedDescription)")
                    print("fetchCategory Api- \(error.localizedDescription)")
                }
            }.resume()
        }else {
            completionHandler([], "")
        }
    }
    
}

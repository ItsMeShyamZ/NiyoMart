//
//  Webservices.swift
//  D911 Agency
//
//  Created by Abservetech on 05/02/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import SystemConfiguration
import UIKit

struct Resource<T>{
    var vc : UIViewController
    var url : String
    var method : HTTPMethods
    var params : [String : Any]? = nil
//    var parse : (Data) -> T?
}

enum isBaseApiURL {
    case yes
    case no
    case settingurl
}


public enum YesNoType {
    case yes
    case no
}

enum HTTPMethods : String{
    case get     = "GET"
    case post    = "POST"
    case delete  = "DELETE"
    case put     = "PUT"
    case patch   = "PATCH"
    
}

enum ApiClientError : Error{
    case noInternet
    case apiConnection
    case serverError
    
}

extension ApiClientError : LocalizedError{
    var errorDescription : String?{
        switch self {
        case .noInternet :
            return HttpError.noInternet.localize
        case .apiConnection :
            return HttpError.apiConnection.localize
        case .serverError :
            return HttpError.serverError.localize
        default:
            return HttpError.somthingWentWrong.localize
        }
    }
}

public class Reachability {
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        if flags.isEmpty {
            return false
        }

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return (isReachable && !needsConnection)
    }
}

class WebService {
    public static var shared = WebService()
    private static var ContentType_HeaderKey = "Content-Type"
    private static var Authorization_HeaderKey = "Authorization"
    
    
    func loadData<T : Codable>(resource : Resource<T> , withAppURL isbase : isBaseApiURL = .yes , isLoaderNeed : YesNoType = .yes ,complition : @escaping (Swift.Result<T,ApiClientError> , _ statusCode : Int ) -> Void){
        if Reachability().isConnectedToNetwork(){
            var urlString : String = isbase == .yes ? (Api.baseURL + resource.url) : (isbase == .settingurl ? (Api.settingURL + resource.url) : resource.url)
         
            guard let url : URL = URL(string: urlString) else {
                Log.er("URLError,\(urlString)")
                return}
         
               
            var request  = URLRequest(url:url)
            request.httpMethod = resource.method.rawValue
            if isLoaderNeed == .yes {
                LoadingShow(view: resource.vc.view)
                resource.vc.view.endEditing(true)
            }
            
            guard let httpbody = try? JSONSerialization.data(withJSONObject: resource.params ?? ["" : ""], options: []) else {return}
            if resource.method != .get{
                request.httpBody = httpbody
            }
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(UserDefaultConfig.Token, forHTTPHeaderField: "x-access-token")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.sync {
                     if isLoaderNeed == .yes {
                    LoadingHide(view: resource.vc.view)
                    }
                }
                if error != nil{
                    Log.er(url : urlString ,"\(resource.params) ")
                    complition(.failure(.apiConnection), 0)
                    return
                }
                guard let response = response as? HTTPURLResponse  else{
                    guard data != nil else { return }
                    
                    complition(.failure(.serverError), 0)
                    return
                }
                guard let data = data else {
                    complition(.failure(.noInternet), 0)
                    return
                }
                do{
                    let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    Log.rq(url : urlString ,"\(resource.params) ===> \(jsonStr)====>\(UserDefaultConfig.Token) =====? \(T.self)")
                    guard let responseData = try? JSONDecoder().decode(T.self, from: data) else {
                        Log.er(url : urlString ,"Cont Decode, check you Model")
                        return
                    }
                    DispatchQueue.main.sync {
                          complition(.success(responseData), (response as? HTTPURLResponse)?.statusCode ?? 0)
                    }
                }catch{
                    Log.er(url : urlString ,"JSONERROR")
                }
            }.resume()
        }else{
//            let vc = OfflineVC.initVC(storyBoardName: .main, vc: OfflineVC.self, viewConrollerID: .offline)
//                     vc.bgImage = resource.vc.view.asImage()
//            resource.vc.present(vc: vc)
        }
    }
    
    
    func imageUpload<T : Codable>(resource : Resource<T> , withAppURL isbase : isBaseApiURL = .yes , isLoaderNeed : YesNoType = .yes,imageToUpload : [ImageWithKey] ,complition : @escaping (Swift.Result<T,ApiClientError> , _ statusCode : Int ) -> Void){
        if Reachability().isConnectedToNetwork(){
            let urlString : String = isbase == .yes ? (Api.baseURL + resource.url) : (isbase == .settingurl ? (Api.settingURL + resource.url) : resource.url)
            guard let url : URL = URL(string: urlString) else {return}
            var request  = URLRequest(url:url)
            request.httpMethod = resource.method.rawValue
            resource.vc.view.endEditing(true)
            
            let boundary = generateBoundary()
            var mediaData = [Media]()
            for image in imageToUpload{
                guard let mediaImage = Media(withImage: image.image ?? UIImage(), forKey: image.key ?? "") else {
                    Log.er(url: urlString, "Error in Image upload")
                    return
                }
                mediaData.append(mediaImage)
            }
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            let parameters = resource.params ?? ["" : ""]
            
            let dataBody = createDataBody(withParameters: parameters as? Parameters, media: mediaData, boundary: boundary)
            
            if resource.method != .get{
                request.httpBody = dataBody
            }
            
            request.setValue(UserDefaultConfig.Token, forHTTPHeaderField: "x-access-token")
            if isLoaderNeed == .yes {
                LoadingShow(view: resource.vc.view)
            }
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.sync {
                    LoadingHide(view: resource.vc.view)
                }
                if error != nil{
                    complition(.failure(.apiConnection), 0)
                    Log.rq(url : urlString ,"\(resource.params) \(imageToUpload) ===> \(error)====>\(UserDefaultConfig.Token) =====? \(T.self)")
                                
                    return
                }
                guard let response = response as? HTTPURLResponse  else{
                    guard data != nil else { return }
                    
                    complition(.failure(.serverError), 0)
                    return
                }
                guard let data = data else {
                    complition(.failure(.noInternet), 0)
                    return
                }
                do{
                    let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                    Log.rq(url : urlString ,"\(resource.params) \(imageToUpload)===> \(jsonStr)====>\(UserDefaultConfig.Token) =====? \(T.self)")
                    guard let responseData = try? JSONDecoder().decode(T.self, from: data) else {
                        Log.er("Cont Decode, check you Model")
                        return
                    }
                    DispatchQueue.main.sync {
                        complition(.success(responseData), (response as? HTTPURLResponse)?.statusCode ?? 0)
                    }
                }catch{
                    Log.er(url : urlString ,"JSONERROR")
                }
            }.resume()
        }else{
//            let vc = OfflineVC.initVC(storyBoardName: .main, vc: OfflineVC.self, viewConrollerID: .offline)
//            vc.bgImage = resource.vc.view.asImage()
//            resource.vc.present(vc: vc)
        }
    }
    
}

func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
      
      let lineBreak = "\r\n"
      var body = Data()
      
      if let parameters = params {
          for (key, value) in parameters {
              body.append("--\(boundary + lineBreak)")
              body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
              body.append("\(value)" + "\(lineBreak)")
          }
      }
      
      if let media = media {
          for photo in media {
              body.append("--\(boundary + lineBreak)")
              body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
              body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
              body.append(photo.data)
              body.append(lineBreak)
          }
      }
      
      body.append("--\(boundary)--\(lineBreak)")
      return body
  }
  
  func generateBoundary() -> String {
      return "Boundary-\(NSUUID().uuidString)"
  }


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "\(arc4random()).jpeg"
        
        
        guard let data = image.jpegData(compressionQuality: 0.7 ) else {
            Log.er("ERRRRRRRR")
            return nil }
        self.data = data
    }
    
}
struct ImageWithKey {
     let key: String?
     let image: UIImage?
      
}

typealias Parameters = [String: Any]

func LoadingShow(view : UIView){
    view.endEditing(true)
//    let hud = MBProgressHUD.showAdded(to: view, animated: true)
//    hud?.labelText = "Loading..."
//    hud?.dimBackground = false
    //     AlertBuilder().addView(fromVC: view.parentViewController ?? UIViewController() , AlertLoder.getView).showlodingView()
    
}
func LoadingHide(view : UIView){
    //    AlertBuilder().addView(fromVC: view.parentViewController ?? UIViewController() , AlertLoder.getView).dismiss()
//    MBProgressHUD.hideAllHUDs(for: view, animated: true)
}

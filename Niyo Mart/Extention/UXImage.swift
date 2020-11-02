//
//  UXImage.swift
//  Gron
//
//  Created by Abservetech on 20/02/20.
//  Copyright © 2020 Abservetech. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage

class SZUserImage : UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.circleImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.circleImage()
    }
    
    func circleImage(){
        self.layer.cornerRadius = self.frame.width / 2
        self.contentMode = .scaleToFill
        if #available(iOS 13.0, *) {
            self.layer.borderColor = UIColor.whiteColor.cgColor
        } else {
            self.layer.borderColor = UIColor.white.cgColor
        }
        self.layer.borderWidth = 5
    }
}


class SZImage : UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.circleImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.circleImage()
    }
    
    func circleImage(){
        self.layer.cornerRadius = self.frame.width / 2
        self.contentMode = .scaleToFill
        if #available(iOS 13.0, *) {
            self.layer.borderColor = UIColor.whiteColor.cgColor
        } else {
            self.layer.borderColor = UIColor.white.cgColor
        }
        self.layer.borderWidth = 3
    }
}

    enum AssetName : String{
        case menu = "Menu"
        case back = "MenuBack"
        case menuBack = "Back"
        case arrow = "arrow"
        case menu_post_ride = "PostRide"
        case menu_my_rides = "MyRide"
        case menu_rides = "MyRides"
        case menu_payments = "Payments"
        case menu_review_rating = "ReviewRating"
        case menu_my_offer = "MyOffers"
        case menu_refer_friend = "Refer"
        case menu_settings = "Settings"
        case support = "Support"
        case logo = "Logo"
        case share_ride = "Share Rides"
        case fine_car_ride = "Find Car Rides"
        case user_verficatio = "user_verficatio"
        case customer_support = "Customer support"
        case sett_acc = "Account"
        case sett_pri = "Privacy"
        case sett_carpool = "Carpool"
        case sett_noti = "Notification"
        case sett_save_loc = "SaveLoc"
        case sett_partner = "ride_partner"
        case sett_block = "Blocked"
        case sett_holiday = "Holiday"
        case sett_reset = "Reset"
        case sett_logout = "Logout"
        case eye_open = "EyeOpen"
        case eye_close = "EyeClose"
        case welcome = "welcome"
        case check_box = "UnChecked"
        case checked_box = "Checked"
        case radio_on = "RadioON"
        case radio_off = "RadioOFF"
        case invite_friends = "InviteFriends"
        case launcher = "Lancher"
        case add_vehicle = "AddVehicle"
        case profile_bg = "ProfileBG"
        case profile_acc = "AccountProfile"
        case profile_edit = "Edit"
        case cross = "Cross"
        case menu_option = "Menu_option"
        case default_selection = "Tick"
        case bike = "Bike"
        case info = "Info"
        case License = "License"
        case Location = "Location"
        case Nodatacar = "Nodatacar"
        case Rupee = "Rupee"
        case Seat = "Seat"
        case Car = "Car"
        case Close = "Close"
        case License_expire = "_license_expire"
        case License_user = "License_user"
        case Plus = "Plus"
        case Down_arrow = "Down_arrow"
        case circle = "Circle"
        case upper_pin = "_upper_pin"
        case Stripe_line = "_stripline"
        case Block = "Block"
        case freeze = "Freeze"
        case calendar = "calendar"
        case delete = "Delete"
        case current_location = "Current_loc"
        case map_refresh = "Refersh_ride"
        case findIcon = "Find_ride"
        static var  offerIcon = AssetName.menu_rides
        case red_circle = "Red_circle"
        case green_circle = "Green_circle"
        case date_time = "Date_time"
        case small_Car = "carsmall"
        case double_arrow = "Double_arrow"
        case pickup_loc = "_pickup_loc"
        case midpoint_marker = "midpoint_marker"
        case drop_loc = "Drop_loc"
        case cancel_ride = "Ride_Cancel"
        case find_ride = "Ride_find"
        case end_marker = "Endmarker"
        case start_marker = "_startmarker"
        case circle_marker = "circle_walk"
        case verify = "Verify"
        case wallet = "Wallet"
        case right_arrow = "Right_arrow"
        case invite = "Invite"
        case request = "_request"
        case call = "Call"
        case chat = "Chat"
        case sms = "Sms"
        case map = "Map"
        case close_circle = "Close_circle"
        case trip_block = "Block_user"
        case trip_fav = "Trip_user"
        case chat_send = "ChatSend"
        case ride_accept = "Ride_accept"
        case single_tick = "single_tick"
        case double_tick = "double_tick"
        case sos = "_sos"
        case emergency = "_emergency"
        case transaction_history = "Transaction_history"
        case Car_marker = "car_marker"
        case Bike_marker = "bike_marker"
        case map_route = "route_map"
        case search = "_search"
        case helmet = "security"
        case No_Internet = "No_internet"
        case refersh = "freshen"
        case none = ""

        static let values = [menu]
    }

enum SystemName : String{

    case left_arrow = "chevron.left"
}

enum LottieName : String{
    case start_ride = "car_animate"
}
    
extension UIImageView{
    
        func setImages(_ name : AssetName , _ withTint : YesNoType = .no, _ withTintColor : UIColor = UIColor.whiteColor ){
            if withTint == .no{
                self.image = (UIImage(named: name.rawValue) ?? UIImage())
            }else{
                if #available(iOS 13.0, *) {
                    self.image = (UIImage(named: name.rawValue) ?? UIImage()).withTintColor(withTintColor)
                } else {
    //                self.image = (UIImage(named: name.rawValue) ?? UIImage())
    //                self.tintColor = withTintColor
                    if let TintImage = (UIImage(named: name.rawValue)){
                        let tintableImage = TintImage.withRenderingMode(.alwaysTemplate)
                        self.image = tintableImage
                    }
                    self.tintColor = withTintColor
                    self.image = self.image?.imageWithColor(color: withTintColor)
                }
            }
        }
   
    func setImage(_ name : AssetName , _ withTint : YesNoType = .no, _ withTintColor : UIColor = UIColor.whiteColor ){
        if withTint == .no{
            self.image = (UIImage(named: name.rawValue) ?? UIImage())
        }else{
            if #available(iOS 13.0, *) {
                self.image = (UIImage(named: name.rawValue) ?? UIImage()).withTintColor(withTintColor)
            } else {
//                self.image = (UIImage(named: name.rawValue) ?? UIImage())
//                self.tintColor = withTintColor
                if let TintImage = (UIImage(named: name.rawValue)){
                    let tintableImage = TintImage.withRenderingMode(.alwaysTemplate)
                    self.image = tintableImage
                }
                self.tintColor = withTintColor
                self.image = self.image?.imageWithColor(color: withTintColor)
            }
        }
    }
    
    func setURLImage(_ url : String){
        if !url.isEmpty{
        self.pin_setImage(from: URL(string: url) ?? URL(string: ""))
        }
    }
    
    func getURLImage(_ url : String) -> UIImage{
        let testImage = UIImageView()
        testImage.setURLImage(url)
        return testImage.image ?? UIImage()
    }
    
    }

func getImages(_ name : AssetName , _ withTint : YesNoType = .no, _ withTintColor : UIColor = UIColor.whiteColor )-> UIImage{
      if withTint == .no{
          return (UIImage(named: name.rawValue) ?? UIImage())
         
      }else{
          if #available(iOS 13.0, *) {
             return (UIImage(named: name.rawValue) ?? UIImage()).withTintColor(withTintColor)
          } else {
             let testImage = UIImageView()
            testImage.image = (UIImage(named: name.rawValue) ?? UIImage())
              testImage.tintColor = withTintColor
            return testImage.image ?? UIImage()
          }
      }
  }

func getImage(_ name : AssetName , _ withTint : YesNoType = .no, _ withTintColor : UIColor = UIColor.whiteColor )-> UIImage{
      if withTint == .no{
          return (UIImage(named: name.rawValue) ?? UIImage())
         
      }else{
          if #available(iOS 13.0, *) {
             return (UIImage(named: name.rawValue) ?? UIImage()).withTintColor(withTintColor)
          } else {
             let testImage = UIImageView()
            testImage.image = (UIImage(named: name.rawValue) ?? UIImage())
              testImage.tintColor = withTintColor
            return testImage.image ?? UIImage()
          }
      }
  }


extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()

        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

class ImageLoader: UIImageView {
    
    @IBInspectable var change_image:Bool = false
    
    override func awakeFromNib() {
        Color()
    }
    func Color(){
        if change_image{
            self.image = self.image!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        }
    }
}

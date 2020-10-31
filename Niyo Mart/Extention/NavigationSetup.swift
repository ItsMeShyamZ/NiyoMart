

import Foundation
import UIKit

public enum navigateFrom : String{
    case login
    case signup
    case none
}

public enum storyboardName : String{
    case main = "Main"
    case account = "Account"
    case home = "Home"
    case setting = "SupportSettings"
    case myride = "MyRides"
    case payment = "Payments"
    
}

public enum VCID : String{
    case viewcontroller = "ViewController"
    case offline = "OfflineVC"
    case launcher = "LauncherVC"
    case splash = "SplashVC"
    case account = "Account"
    case login = "LoginVC"
    case signup = "SignupVC"
    case menu = "MenuVC"
    case home = "HomeVC"
    case home_startRide = "HomeVC_start"
    case profile = "ProfileVC"
    case editprofile = "EditPRofileVC"
    case container = "ContainerVC"
    case support = "SupportVC"
    case settings = "SettingsVC"
    case myRidePC = "MyRidePageControllerVC"
    case upcoming = "UpcomingRideVC"
    case recurring = "RecurringRideVC"
    case pastrides = "PastRideVC"
    case refer = "ReferVC"
    case offer = "OfferVC"
    case rating_review = "ReviewRatingVC"
    case donate = "DonateVC"
    case redeem = "RedeemVC"
    case recharge = "RechargeVC"
    case payment = "PaymentPageControllerVC"
    case mobile_otp = "MobileOTPVC"
    case alert = "AlertVC"
    case forgot = "ForgotVC"
    case reset = "ResetPassVC"
    case holiday = "HolidayVC"
    case privacy = "PrivacyVC"
    case blockfav = "BlockFavVC"
    case chat = "ChatVC"
    case transaction = "TransactionVC"
    case transfer = "TransferVC"
    case accountVC = "AccountVC"
    case verifyOrg = "VerifyOrgVC"
    case companySearch = "CompanySearchVC"
    case carpooling = "CarpoolingVC"
    case vehicleList = "VehicleListVC"
    case viewVehicle = "ViewVehicleVC"
    case savedLocation = "SavedLocationVC"
    case searchAddress = "SearchAddressVC"
    case selectAddress = "SelectAddressVC"
    case license = "LicenseVC"
    case addVehicle = "AddVehicleVC"
    case offerRide = "OfferRideDetailVC"
    case findRidedetail = "FindRideDetailVC"
    case feedback = "FeedBackVC"
    case recurringShedule = "RecurringVC"
    case notification  = "NotificationVC"
    case postVehicle = "PostRideVehicleVC"
    case editRide = "EditRideVC"
    case editroute = "EditRouteVC"
    case ridemain = "RideMainVC"
    case MatchingOption = "MatchingOptionVC"
    case RideTaker = "RideTakerVC"
    case Contacts = "ContactsVC"
    case tripProfile = "TripUserProfileVC"
    case chatmsg = "ChatMsgVC"
    case tripuserdetail = "TripUserDetailVC"
    case forceLogout = "ForceLogoutVC"
    
}

public enum viewID : String{
    case term_con = "TermsConditionView"
    case mobileOTP = "MobileOTPView"
}

public enum viewXib : String{
    case account_alert = "AccountCustomView"
    case setting_alert = "SettingustomViews"
    case ride_alert = "RideCustomView"
    case tripuser_alert = "TripUserView"
}



public enum cellID : String {
    case menu = "MenuCell"
    case setting = "SettingCell"
    case rideInfo = "RideInfoCell"
    case tripUser = "RideUserCell"
    case offer = "OfferCell"
    case rating = "RatingReviewCell"
    case user = "UserCell"
    case transcation = "TransactionCell"
    case search = "SearchCell"
    case viewVehicle = "ViewVehicleCell"
    case AddVehicle = "AddVehicleCell"
    case location = "LocationCell"
    case tripBill = "TripBillingCell"
    case schudle = "SchudleCell"
    case notification = "NotificationCell"
    case ridetaker = "RideTakerCell"
    case chatLeft = "ChatLeftCell"
    case chatRight = "ChatRightCell"
    case address = "AddressCell"
}

public enum NavigationOption : String{
    case onboard
    case launcher
    case home
    case login
    case logout
    case payment
    case forceLogout
}

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}

extension UIViewController{
    
    
    var identifiers : String{
        return "\(self)"
    }
    
   static func getStoryBoard(withName name : storyboardName) -> UIStoryboard{
        return UIStoryboard.init(name: name.rawValue, bundle: Bundle.main)
    }
    
   static func initVC<T : UIViewController>(storyBoardName name : storyboardName , vc : T.Type , viewConrollerID id : VCID) -> T{
        return getStoryBoard(withName: name).instantiateViewController(withIdentifier: id.rawValue) as! T
    }
    
    func push<T : UIViewController>(from vc : T ,ToViewContorller contoller : UIViewController ){
        vc.navigationController?.pushViewController(contoller, animated: true)
    }
    
    func pop<T:UIViewController>(from vc : T){
        vc.navigationController?.popViewController(animated: true)
    }
    
  
    func present<T : UIViewController>(vc : T, _ isFullyPresent : YesNoType = .no){
        let vcl = vc
        if isFullyPresent == .no{
            vcl.modalPresentationStyle = .custom
        }else{
            vcl.modalPresentationStyle = .fullScreen
        }
        self.present(vc, animated: false, completion: nil)
    }
    func popMultipleVC(popViews: Int) {
        if self.navigationController!.viewControllers.count > popViews
        {
            let vc = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - popViews - 1]
             self.navigationController?.popToViewController(vc, animated: false)
        }
    }
    
   
    
}

struct Navigation {
    
    static func navigateTo(screen name : String){
         print("AppState" , name)
        var rootVC : UIViewController?
        switch name {
        case NavigationOption.onboard.rawValue:
            rootVC = ViewController.initVC(storyBoardName: .main, vc: ViewController.self, viewConrollerID: .viewcontroller)
        case NavigationOption.logout.rawValue:
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
            UserDefaultConfig.AppState = NavigationOption.launcher.rawValue
            UserDefaultConfig.UserID = ""
            UserDefaultConfig.UserName = ""
            UserDefaultConfig.Token = ""
            
//            rootVC = SplashVC.initVC(storyBoardName: .account, vc: SplashVC.self, viewConrollerID: .splash)
       
        default:
              rootVC = ViewController.initVC(storyBoardName: .main, vc: ViewController.self, viewConrollerID: .viewcontroller)
        }
        let navigationController = UINavigationController(rootViewController: rootVC!)
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.tintColor = UIColor.whiteColor
        if #available(iOS 13.0,*){
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = navigationController
            appDelegate.window?.makeKeyAndVisible()
        }
    }
    
   
}

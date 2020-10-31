//
//  HomePageView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 17/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class HomePageView: UIViewController {
    
    
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var hamButton: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var homePageTabBar: UITabBar!
    @IBOutlet weak var homeTabBarItem: UITabBarItem!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var offerImageView: UIImageView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    let imageArray : [UIImage] = [UIImage(named: "HomeNeeds.png")!, UIImage(named: "HomeEss.png")!, UIImage(named: "Kids.png")!, UIImage(named: "Ladies.png")!, UIImage(named: "Snacks.png")!]
    
    var categoryList : [CategoryModel] = []
    
    @IBAction func searchBtnTpd(_ sender: Any) {
    
    }
    
    @IBAction func hamBtnTpd(_ sender: Any) {
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.loadDataFromApi()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuCollectionView.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
//        menuCollectionView.register(UICollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        menuCollectionView.register(UINib(nibName: "MenuHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        menuCollectionView.register(UICollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")


        
        homePageTabBar.delegate = self
        homePageTabBar.selectedItem = homeTabBarItem
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
    }
}


extension HomePageView : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            
        }else if item.tag == 1 {
            let view = CartView.init(nibName: "CartView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: false)
        }else if item.tag == 2 {
            let view = ProfileOptionsView.init(nibName: "ProfileOptionsView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: false)
        }else if item.tag == 3 {
            
        }
    }
}

//extension HomePageView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        let height = menuCollectionView.frame.size.height
//        let width = view.frame.size.width
//        return CGSize(width: width * 0.25, height: width * 0.35)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 5
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell : MenuCell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! MenuCell
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        menuCollectionView.deselectItem(at: indexPath, animated: false)
//        let view = SubCategoryView.init(nibName: "SubCategoryView", bundle: nil)
//        self.navigationController?.pushViewController(view, animated: false)
//    }
//
//}
extension HomePageView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let height = menuCollectionView.frame.size.height
        let width = view.frame.size.width
        return CGSize(width: width * 0.25, height: width * 0.35)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MenuCell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! MenuCell
        cell.imgView.image = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuCollectionView.deselectItem(at: indexPath, animated: false)
        let view = SubCategoryView.init(nibName: "SubCategoryView", bundle: nil)
        self.navigationController?.pushViewController(view, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: menuCollectionView.frame.size.width, height: 50.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView : MenuHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath as IndexPath) as! MenuHeaderView
            
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath as IndexPath)
            
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension HomePageView{
    func getCategoryList(){
        let resource = Resource<CategoryModel>(vc: self, url: Api.category.categoryList, method: .get ,params : nil)
        
        WebService.shared.loadData(resource: resource,withAppURL: .settingurl) { (result , statusCode)  in
            self.hideLoader()
            switch result{
                case .success(let data) :
                    if statusCode.isResponseOK() {
                        Log.rs(url : Api.category.categoryList,data)
                       
                    }else{
                        Log.er(url : Api.category.categoryList,data)
                    }
                    break
                case .failure(let error) :
                    Log.er(url : Api.category.categoryList,error.localizedDescription)
                    break
            }
        }
    }
    
        
        func loadDataFromApi() -> Void {
            headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
            showLoader(withTitle: "", and: "")
            ApiManager.shared.fetchCategory { (categoryList, errorMsg) in
                if errorMsg == "" {
                    self.categoryList = categoryList
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.menuCollectionView.reloadData()
                    }
                }else {
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.showToast(message: errorMsg)
                    }
                }
            }
            
        }
}

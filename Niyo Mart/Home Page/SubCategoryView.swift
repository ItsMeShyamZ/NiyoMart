//
//  SubCategoryView.swift
//  Niyo Mart
//
//  Created by AmuthaPMM  on 25/09/20.
//  Copyright © 2020 MuthuPersonal. All rights reserved.
//

import UIKit

class SubCategoryView: UIViewController {
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var catTabBar: UITabBar!
    @IBOutlet weak var homeTabBarItem: UITabBarItem!
    
    var category : CategoryModel?
    private let spacing:CGFloat = 1.0
    var SubCategoryList : [CategoryModel] = []
    
    @IBAction func backButtonTpd(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
        
    }
    
    @IBAction func searchButtonTpd(_ sender: Any) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadDataFromApi()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryCollectionView.register(UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.categoryCollectionView?.collectionViewLayout = layout
        
        catTabBar.delegate = self
        catTabBar.selectedItem = homeTabBarItem
        loadUi()
    }
}

extension SubCategoryView {
    
    func loadUi() -> Void {
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
    }
    
}


extension SubCategoryView : UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            let view = HomePageView.init(nibName: "HomePageView", bundle: nil)
            self.navigationController?.pushViewController(view, animated: false)
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


extension SubCategoryView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 3
        let spacingBetweenCells:CGFloat = 2
        
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        if let collection = self.categoryCollectionView{
            let width = (collection.bounds.width - totalSpacing)/numberOfItemsPerRow
            return CGSize(width: width, height: width)
        }else{
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.SubCategoryList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MenuCell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! MenuCell
        cell.imgView.setURLImage(self.SubCategoryList[indexPath.row].category_image ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let view = ProductListView.init(nibName: "ProductListView", bundle: nil)
        view.category = self.SubCategoryList[indexPath.row]
        self.navigationController?.pushViewController(view, animated: false)
        
    }
    
}

extension SubCategoryView{
    func loadDataFromApi() -> Void {
        headerTitleLabel.font = UtilCollections.shared.getHeaderTitleFont()
        showLoader(withTitle: "", and: "")
        ApiManager.shared.fetchSubCategory(categoryid:"\(self.category?.category_id ?? 0)") { (categoryList, errorMsg) in
            if errorMsg == "" {
                self.SubCategoryList = categoryList
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.categoryCollectionView.reloadData()
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

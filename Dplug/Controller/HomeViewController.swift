//
//  FirstViewController.swift
//  Dplug
//
//  Created by Lan Tran on 8/20/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var bannerView: BannerView!
    
    var listCategories: [CategoriesModel] = [] {
        didSet {
            ShareInstanceModel.shareInstance.categories = listCategories
            menuCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBanner()
        initMenuCollectionView()
        loadCategories()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension HomeViewController {
    func getBanner(){
        bannerView.imagesList = ["logo.png","logo.png", "logo.png","logo.png","logo.png", "Home.png"]
    }
    
    func initMenuCollectionView() {
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        let cell = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        menuCollectionView.register(cell, forCellWithReuseIdentifier: "homeCollectionViewCell")
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width - 30)/2
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}

extension HomeViewController: UICollectionViewDelegate {

    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        if let catName = listCategories[indexPath.row].name {
            cell.categoriesNameLabel.text = catName
            return getCatImage(indexPath: indexPath, cell: cell)
            
        } else {
            cell.categoriesNameLabel.text = ""
            return getCatImage(indexPath: indexPath, cell: cell)
        }
    }
}

extension HomeViewController {
    
    func loadCategories() {
        APIService.shareInstance.getCategories { result in
            if let cat = result as? NSDictionary {
                self.listCategories = CategoriesModel().parseCategories(data: cat)
            }
        }
    }
    func getCatImage(indexPath: IndexPath, cell: HomeCollectionViewCell) -> HomeCollectionViewCell {
        guard let catImage = listCategories[indexPath.row].image else {
            return cell
        }
        let catURL = URL(string: catImage)
        cell.categoriesImageView.kf.setImage(with: catURL)
        return cell
    }
}

//
//  FirstViewController.swift
//  Dplug
//
//  Created by Lan Tran on 8/20/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var bannerView: BannerView!
        override func viewDidLoad() {
        super.viewDidLoad()

        getBanner()
        initMenuCollectionView()
            
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "homeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        return cell
    }
}

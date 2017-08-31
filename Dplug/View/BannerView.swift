//
//  BannerView.swift
//  Dplug
//
//  Created by Lan Tran on 8/20/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class BannerView: UIView {
    var scrollView = UIScrollView()
    @IBOutlet var bannerView: UIView!
   @IBOutlet weak var pageControl: UIPageControl!

    
    var imagesList:[String] = [] {
        didSet {
            initScrollView()
            configurePageControl()
            addImageView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.red
        Bundle.main.loadNibNamed("BannerView", owner: self, options: nil)
        self.addSubview(self.bannerView)
        
        self.bannerView.translatesAutoresizingMaskIntoConstraints = false
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self.bannerView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options:NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["view": self.bannerView]))
    }
}

extension BannerView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}

extension BannerView {
    func initScrollView() {
        print("\(self.frame.height)")
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        
        self.addSubview(scrollView)
        
        
        let overlayViewTop = UIView()
        overlayViewTop.frame =  CGRect(x: 0, y: 0, width: self.frame.width, height: 20)
        overlayViewTop.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.addSubview(overlayViewTop)
        
        
        let overlayViewBot = UIView()
        overlayViewBot.frame =  CGRect(x: 0, y:(self.frame.height-20), width: self.frame.width, height: 20)
        overlayViewBot.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        self.addSubview(overlayViewBot)

    }
    
    func configurePageControl() {
        
        self.pageControl.numberOfPages = imagesList.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.green
        //self.addSubview(pageControl)
    }
    
    func addImageView() {
        for  i in 0 ..< imagesList.count{
            let x = self.scrollView.frame.size.width * CGFloat(i)
            
            let myImage:UIImage = UIImage(named: self.imagesList[i])!
            let myImageView:UIImageView = UIImageView()
            myImageView.image = myImage
            myImageView.frame = CGRect(x: x, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            //myImageView.layer.zPosition = -1
            scrollView.addSubview(myImageView)
            
            
            
        }
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imagesList.count), height: self.scrollView.frame.size.height)
        pageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
    }
    
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }

}


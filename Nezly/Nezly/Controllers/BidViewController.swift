//
//  BidViewController.swift
//  Nezly
//
//  Created by Nguyen on 11/3/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

class BidViewController: UIViewController {
   
    // MARK: -IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var listCollectionView2: UICollectionView!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var bidButton: UIButton!
    @IBOutlet weak var rectangleView: UIView!
    @IBOutlet weak var labresultsButton: UIButton!
    @IBOutlet weak var proofoflifeButton: UIButton!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var containerView2: UIView!
    @IBOutlet weak var heightcontentView: NSLayoutConstraint!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    
    var postArrays = [Post]()
    var posts = [Post]()
    var post: Post!
    
    static let storyboadId = "BidViewController"
    
    // MARK: -View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightConstraint.priority = UILayoutPriority(rawValue: 999)
        
        getCellFromNib()
        setPagecontrol()
        setUI()
        setNavigationUI()
        customProgressView()
        renderData()
        setColor()
        //addBackgroundGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            DispatchQueue.main.async {
                self.listCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.heightcontentView.constant = self.listCollectionView2.frame.origin.y + self.listCollectionView2.collectionViewLayout.collectionViewContentSize.height + 100.0
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    // MARK: -IBAction
    @IBAction func Back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectedChat(_ sender: Any) {
        chatButton.backgroundColor = UIColor(hex: 0x8863D5)
        chatButton.layer.borderWidth = 0
    }
    
    @IBAction func selectedBid(_ sender: Any) {
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        self.present(popup, animated: true)
        
        bidButton.backgroundColor = UIColor(hex: 0x8863D5)
        bidButton.layer.borderWidth = 0
    }
    
    @IBAction func more(_ sender: Any) {
        
    }
    
    // MARK: -GradientColectionview
//    private func addBackgroundGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = listCollectionView.bounds
//        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
//        listCollectionView.layer.insertSublayer(gradientLayer, at: 0)
//    }
    
    private func getCellFromNib() {
        listCollectionView.getCellFromNib(identifier: "ListingCollectionViewCell")
        listCollectionView2.getCellFromNib(identifier: "AuctionCollectionViewCell")
    }
    
    private func setNavigationUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        self.pageControl?.currentPage = Int(roundedIndex)
    }
    
    private func setPagecontrol() {
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
    }
    
    private func setUI() {
        chatButton.layer.borderWidth = 1
        chatButton.layer.borderColor = UIColor.white.cgColor
        bidButton.layer.borderWidth = 1
        bidButton.layer.borderColor = UIColor.white.cgColor
        followButton.layer.cornerRadius = 3
        containerView2.layer.cornerRadius = 13
        labresultsButton.layer.cornerRadius = 3
        proofoflifeButton.layer.cornerRadius = 3
    }
    
    private func setColor() {
        containerView.backgroundColor = UIColor(hex: 0x472E7D)
        bidButton.backgroundColor = UIColor(hex: 0x472E7D)
        chatButton.backgroundColor = UIColor(hex: 0x472E7D)
        rectangleView.backgroundColor = UIColor(hex: 0x472E7D)
        labresultsButton.backgroundColor = UIColor(hex: 0x8863D5)
        proofoflifeButton.backgroundColor = UIColor(hex: 0x8863D5)
        followButton.backgroundColor = UIColor(hex: 0x8863D5)
        containerView2.backgroundColor = UIColor(hex: 0x8863D5)
    }
    
    //CustomProgressView
    private func customProgressView() {
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 8)
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
        progressView.tintColor = UIColor(hex: 0x8863D5)
    }
    
    private func renderData() {
        titleLabel.text = post.title
        priceLabel.text = "$" + String(post.price) + " Liter"
        quantityLabel.text = String(post.quantity) + " Liters"
        descriptionLabel.text = post.description
    }
    
    private func setFontdata() {
        titleLabel.font = UIFont.OpenSansExtrabold(size: 19)
        priceLabel.font = UIFont.OpenSansSemibold(size: 19)
        quantityLabel.font = UIFont.OpenSansSemibold(size: 19)
        descriptionLabel.font = UIFont.OpenSansRegular(size: 14)
    }
    
}

extension BidViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.listCollectionView2 {
            return postArrays.count
        } else {
            return postArrays.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.listCollectionView2 {
            let cell = listCollectionView2.dequeueReusableCell(withReuseIdentifier: "AuctionCollectionViewCell", for: indexPath) as! AuctionCollectionViewCell
            cell.titleLabel.text = postArrays[indexPath.row].title
            cell.titleLabel.font = UIFont.OpenSansRegular(size: 12)
            if postArrays[indexPath.row].is_auction == true {
                cell.buyLabel.text = "Auction"
                cell.buyLabel.font = UIFont.OpenSansRegular(size: 13)
            } else if postArrays[indexPath.row].is_buynow == true {
                cell.buyLabel.text = "Buy Now"
                cell.buyLabel.font = UIFont.OpenSansRegular(size: 13)
            } else {
                cell.buyLabel.text = ""
            }
            //loadimage
            if !self.postArrays[indexPath.row].image.image.url.isEmpty {
                cell.imageView.sd_setImage(with: URL(string: self.postArrays[indexPath.row].image.image.url), completed: nil)
            }
            cell.priceLabel.text = "$" + String(postArrays[indexPath.row].price) + " Liter"
            cell.buyLabel.font = UIFont.OpenSansSemibold(size: 13)
            cell.quantityLabel.text = String(postArrays[indexPath.row].quantity) + " Liters"
            cell.quantityLabel.font = UIFont.OpenSansSemibold(size: 13)
            return cell
        } else {
            let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "ListingCollectionViewCell", for: indexPath) as! ListingCollectionViewCell
            if !self.posts[indexPath.row].image.image.url.isEmpty {
                cell.viewImage.sd_setImage(with: URL(string: self.posts[indexPath.row].image.image.url), completed: nil)
            }
            return cell
        }
    }
}

extension BidViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.listCollectionView2 {
            return CGSize(width: (listCollectionView2.frame.width - 10 )/2, height: 290)
        } else {
            return CGSize(width: listCollectionView.frame.width, height: listCollectionView.frame.height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.listCollectionView2 {
            return 0
        } else {
            return 0
        }
    }
        
}

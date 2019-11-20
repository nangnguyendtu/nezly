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

    static let storyboadId = "BidViewController"
    
    // MARK: -View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatButton.layer.borderWidth = 1
        chatButton.layer.borderColor = UIColor.white.cgColor
        bidButton.layer.borderWidth = 1
        bidButton.layer.borderColor = UIColor.white.cgColor
        followButton.layer.cornerRadius = 3
        containerView2.layer.cornerRadius = 13
        labresultsButton.layer.cornerRadius = 3
        proofoflifeButton.layer.cornerRadius = 3
    
        containerView.backgroundColor = UIColor(rgb: 0x472E7D)
        bidButton.backgroundColor = UIColor(rgb: 0x472E7D)
        chatButton.backgroundColor = UIColor(rgb: 0x472E7D)
        rectangleView.backgroundColor = UIColor(rgb: 0x472E7D)
        labresultsButton.backgroundColor = UIColor(rgb: 0x8863D5)
        proofoflifeButton.backgroundColor = UIColor(rgb: 0x8863D5)
        followButton.backgroundColor = UIColor(rgb: 0x8863D5)
        containerView2.backgroundColor = UIColor(rgb: 0x8863D5)
        
        listCollectionView2.getCellFromNib(identifier: "AuctionCollectionViewCell")
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        customProgressView()
        addBackgroundGradient()

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
        chatButton.backgroundColor = UIColor(rgb: 0x8863D5)
        chatButton.layer.borderWidth = 0
    }
    
    @IBAction func selectedBid(_ sender: Any) {
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        self.present(popup, animated: true)
        
        bidButton.backgroundColor = UIColor(rgb: 0x8863D5)
        bidButton.layer.borderWidth = 0
    }
    
    // MARK: -GradientColectionview
    private func addBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = listCollectionView.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.white.cgColor]
        listCollectionView.layer.insertSublayer(gradientLayer, at: 0)
    }
    // MARK: -CustomProgressView
    func customProgressView() {
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 8)
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
        progressView.tintColor = UIColor(rgb: 0x8863D5)
    }
    
}

extension BidViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = listCollectionView2.dequeueReusableCell(withReuseIdentifier: "AuctionCollectionViewCell", for: indexPath) as! AuctionCollectionViewCell
            return cell
    }
}

extension BidViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (listCollectionView2.frame.width - 10 )/2, height: 290)
    }
        
}

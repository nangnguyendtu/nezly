//
//  ListingViewController.swift
//  Nezly
//
//  Created by Nguyen on 10/26/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var listingCollectionView: UICollectionView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var auctionButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchView: UIView!
    
    static let storyboadId = "ListingViewController"
    
    // MARK: -View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoButton.layer.cornerRadius = 17
        infoButton.layer.borderWidth = 1
        infoButton.layer.borderColor = UIColor.white.cgColor
        auctionButton.layer.cornerRadius = 15
        containerView.layer.cornerRadius = 15
        searchView.layer.cornerRadius = 6
        
        auctionButton.backgroundColor = UIColor(rgb: 0x8863D5)
        containerView.backgroundColor = UIColor(rgb: 0x8863D5)
        
        listingCollectionView.getCellFromNib(identifier: "ListingCollectionViewCell")
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    // MARK: -IBAction
    @IBAction func moreinfoButton(_ sender: Any) {
        let bidView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BidViewController") as! BidViewController
        self.navigationController?.pushViewController(bidView, animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showInfo(_ sender: Any) {
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        self.present(popup, animated: true)
    }
}

extension ListingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  listingCollectionView.dequeueReusableCell(withReuseIdentifier: "ListingCollectionViewCell", for: indexPath) as! ListingCollectionViewCell
        return cell
    }
}

extension ListingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
    
    
}
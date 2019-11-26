//
//  ListingViewController.swift
//  Nezly
//
//  Created by Nguyen on 10/26/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class ListingViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var listingCollectionView: UICollectionView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    
    var posts = [Post]()
    var post: Post!
    
    static let storyboadId = "ListingViewController"
    
    // MARK: -View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        infoButton.layer.cornerRadius = 17
        infoButton.layer.borderWidth = 1
        infoButton.layer.borderColor = UIColor.white.cgColor
        buyLabel.layer.cornerRadius = 15
        containerView.layer.cornerRadius = 15
        searchView.layer.cornerRadius = 6
        
        listingCollectionView.getCellFromNib(identifier: "ListingCollectionViewCell")
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        self.hideKeyboardWhenTappedAround()
        setColor()
        renderData()
        setFontdata()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            DispatchQueue.main.async {
                self.listingCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: -IBAction
    @IBAction func moreinfoButton(_ sender: Any) {
        let bidView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BidViewController") as! BidViewController
        bidView.postArrays = posts
        bidView.post = post
        bidView.posts = posts
        navigationController?.pushViewController(bidView, animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showInfo(_ sender: Any) {
        let popup = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        self.present(popup, animated: true)
    }
    
    func scrollToItem(at indexPath: IndexPath,
                      at scrollPosition: UICollectionView.ScrollPosition,
                      animated: Bool){
    }
    
    private func renderData() {
        titleLabel.text = post.title
        priceLabel.text = "$" + String(post.price) + " Liter"
        quantityLabel.text = String(post.quantity) + " Liters"
        if post.is_auction == true {
            buyLabel.text = "Auction"
        } else if post.is_buynow == true {
            buyLabel.text = "Buy Now"
        } else {
            buyLabel.text = ""
        }
    }
    
    private func setFontdata() {
        titleLabel.font = UIFont.OpenSansExtrabold(size: 19)
        priceLabel.font = UIFont.OpenSansSemibold(size: 19)
        quantityLabel.font = UIFont.OpenSansSemibold(size: 19)
        buyLabel.font = UIFont.OpenSansRegular(size: 13)
    }
    
    private func setColor() {
        buyLabel.backgroundColor = UIColor(rgb: 0x8863D5)
        containerView.backgroundColor = UIColor(rgb: 0x8863D5)
    }
    
}

extension ListingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  listingCollectionView.dequeueReusableCell(withReuseIdentifier: "ListingCollectionViewCell", for: indexPath) as! ListingCollectionViewCell
        if !self.posts[indexPath.row].image.image.url.isEmpty {
            cell.viewImage.sd_setImage(with: URL(string: self.posts[indexPath.row].image.image.url), completed: nil)
        }
        return cell
    }
}

extension ListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        titleLabel.text = posts[indexPath.row].title
        priceLabel.text = "$" + String(posts[indexPath.row].price) + " Liter"
        quantityLabel.text = String(posts[indexPath.row].quantity) + " Liters"
        if posts[indexPath.row].is_auction == true {
            buyLabel.text = "Auction"
        } else if posts[indexPath.row].is_buynow == true {
            buyLabel.text = "Buy Now"
        } else {
            buyLabel.text = ""
        }
    }

}

extension ListingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


//
//  HomeViewController.swift
//  Nezly
//
//  Created by Nguyen on 10/8/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var collectionView3: UICollectionView!
    @IBOutlet weak var collectionView4: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
 
    
    
    // MARK: - Variable
    var Arrays1 = ["CANNABIS","CULTIVATION","SERVICES"]
    var Arrays2 = ["FLOWER","CARTRIGES","DIAMONDS","TRIM","PRE-ROLLS"]
    static let storyboadId = "HomeViewController"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    collectionView.getCellFromNib(identifier: "CollectionViewCell")
    collectionView2.getCellFromNib(identifier: "CollectionViewCell")
    collectionView3.getCellFromNib(identifier: "AuctionCollectionViewCell")
    collectionView4.getCellFromNib(identifier: "ListCollectionViewCell")
        
    containerView.layer.cornerRadius = 5
    nameTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
     
    // MARK:
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 91, height: 36))
    imageView.contentMode = .scaleAspectFit
    let image = UIImage(named: "logo")
    imageView.image = image
    navigationItem.titleView = imageView
    
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return Arrays1.count
        }
        if collectionView == self.collectionView2 {
            return Arrays2.count
        }
        if collectionView == self.collectionView4{
            return Arrays2.count
        } else {
            return 4
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.nameButton.setTitle(Arrays1[indexPath.row], for: .normal)
            return cell
        }
        if  collectionView == self.collectionView2 {
            let cell2 = collectionView2.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell2.nameButton.setTitle(Arrays2[indexPath.row], for: .normal)
            cell2.nameButton.setTitleColor(.gray, for: .normal)
            cell2.nameButton.backgroundColor = UIColor.white
            return cell2
        }
        if collectionView == self.collectionView4 {
            let cell4 = collectionView4.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
            cell4.nameLabel?.text = Arrays2[indexPath.row]
            return cell4
        } else {
            let cell3 = collectionView3.dequeueReusableCell(withReuseIdentifier: "AuctionCollectionViewCell", for: indexPath) as! AuctionCollectionViewCell
            return cell3
            
        }
        
    }
   
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            let label = UILabel(frame: CGRect.zero)
            label.text = Arrays1[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width, height: collectionView.frame.height - 10)
        }
        if collectionView == self.collectionView2 {
            let label = UILabel(frame: CGRect.zero)
            label.text = Arrays2[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width, height: collectionView2.frame.height - 20)
        }
        if collectionView == self.collectionView3 {
            return CGSize(width: (collectionView3.frame.width - 10) / 2, height: 290)
        } else {
            let label = UILabel(frame: CGRect.zero)
            label.text = Arrays2[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: collectionView4.frame.height - 15)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.collectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 28)
        }
        if collectionView == self.collectionView2 {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 18)
        }
        if collectionView == self.collectionView3 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
}

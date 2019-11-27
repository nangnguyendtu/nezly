//
//  HomeViewController.swift
//  Nezly
//
//  Created by Nguyen on 10/8/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var parentCollectionView: UICollectionView!
    @IBOutlet weak var subCollectionView: UICollectionView!
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var selectedCollectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topSubView: NSLayoutConstraint!
    @IBOutlet weak var topSeclectedView: NSLayoutConstraint!
    @IBOutlet weak var heightTopview: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var topView: UIView!
    
    // MARK: - Variable
    var postArrays = [Post]()
    var parentArrays = [Category]()
    var subArrays = [Category]()
    var selectedArrays = [Category]()
    var selected = [Int]()
    var selectedSub = [Int]()
    //var selectedParent: Category?
    
    static let storyboadId = "HomeViewController"
    
    // MARK: -View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        getCellFromNib()
        setUI()
        setupTextfield()
        imageView()
        //Loadjson
        loadJson(filename: "categories")
        loadJsonlistings(filename: "listings")
        
        //check font name
//        for family: String in UIFont.familyNames {
//            print("\(family)")
//            for names: String in UIFont.fontNames(forFamilyName: family) {
//                print("== \(names)")
//            }
//        }
    }
    
    private func getCellFromNib() {
        parentCollectionView.getCellFromNib(identifier: "CollectionViewCell")
        subCollectionView.getCellFromNib(identifier: "CollectionViewCell")
        listCollectionView.getCellFromNib(identifier: "AuctionCollectionViewCell")
        selectedCollectionView.getCellFromNib(identifier: "ListCollectionViewCell")
    }
    
    private func setupTextfield() {
        searchTextField.attributedPlaceholder = NSAttributedString(string: searchTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
    }
    
    private func setUI() {
        containerView.layer.cornerRadius = 5
    }
    
    func imageView(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 91, height: 36))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logo")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    func loadJson(filename fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Response.self, from: data)
                self.parentArrays = jsonData.categories
                self.parentCollectionView.reloadData()
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func loadJsonlistings(filename fileName: String) {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Posts.self, from: data)
                self.postArrays = jsonData.posts
            } catch {
                print("error:\(error)")
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.parentCollectionView {
            return parentArrays.count
        }
        if collectionView == self.subCollectionView {
            return subArrays.count
        }
        if collectionView == self.selectedCollectionView{
            return selectedArrays.count
        } else {
            return postArrays.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  collectionView == self.parentCollectionView {
            let cell = parentCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.nameLabel.text = parentArrays[indexPath.row].title.uppercased()
            
            //Equatable
            if let selectedParentId = selected.first {
                if parentArrays[indexPath.item].id == selectedParentId
                {
                    cell.nameLabel.font = UIFont.OpenSansSemibold(size: 15)
                } else {
                    cell.nameLabel.font = UIFont.OpenSansRegular(size: 15)
                }
            }
            return cell
        }
        if  collectionView == self.subCollectionView {
            let cell = subCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.nameLabel.textColor = .gray
            cell.nameLabel.backgroundColor = .white
            cell.nameLabel.text = subArrays[indexPath.row].title.uppercased()
             
                if selectedSub.contains(subArrays[indexPath.row].id)
                {
                    cell.nameLabel.font = UIFont.OpenSansSemibold(size: 15)
                } else {
                    cell.nameLabel.font = UIFont.OpenSansRegular(size: 15)
                }
            return cell
        }
        if collectionView == self.selectedCollectionView {
            let cell = selectedCollectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
            cell.nameLabel.text = selectedArrays[indexPath.row].title.uppercased()
            cell.index = indexPath
            cell.delegate = self
            return cell
        } else {
            let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: "AuctionCollectionViewCell", for: indexPath) as! AuctionCollectionViewCell
            cell.titleLabel.text = postArrays[indexPath.row].title
            cell.titleLabel.font = UIFont.OpenSansRegular(size: 12)
            if postArrays[indexPath.row].is_auction == true {
                cell.buyLabel.text = "Auction"
                cell.buyLabel.backgroundColor = UIColor(hex: 0x472E7D)
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
        }
    }
}
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.parentCollectionView {
            let parent = parentArrays[indexPath.row]
            subArrays = parent.categories ?? []
            subCollectionView.reloadData()
            
            selected = [parent.id]
            parentCollectionView.reloadData()
    
            // MARK: - Change constraint
            view.layoutIfNeeded()
            if self.subArrays.count != 0 {
                self.topSubView.constant = 0
            } else {
                self.topSubView.constant = -45
            }
            UIView.animate(withDuration: 0.5
            , animations: {
                self.view.layoutIfNeeded()
          }, completion: nil)
           
        }
        else if collectionView == self.subCollectionView {
            let sub = subArrays[indexPath.row]
            
            if let index = selectedArrays.firstIndex(of: sub) {
                selectedArrays.remove(at: index)
                selectedCollectionView.reloadData()
                
                selectedSub.remove(at: index)
                subCollectionView.reloadData()
            } else {
                selectedArrays.append(sub)
                selectedCollectionView.reloadData()
                
                selectedSub.append(sub.id)
                subCollectionView.reloadData()
            }
            // MARK: - Change constraint
            view.layoutIfNeeded()
            if self.selectedArrays.count == 0 {
                self.topSeclectedView.constant = -45
                self.heightTopview.constant = 85
            } else {
                self.topSeclectedView.constant = 0
                self.heightTopview.constant = 130
            }
            UIView.animate(withDuration: 0.5
                , animations: {
                    self.view.layoutIfNeeded()
            }, completion: nil)
        }
        else if collectionView == self.listCollectionView {
            let listingView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listingNC") as! UINavigationController
            let vc = listingView.topViewController as! ListingViewController
            //let navController = UINavigationController(rootViewController: listingView)
            vc.posts = postArrays
            vc.post = postArrays[indexPath.row]
            self.present(listingView, animated:true, completion: nil)
        }
    
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.parentCollectionView {
            let label = UILabel(frame: CGRect.zero)
            label.text = parentArrays[indexPath.item].title.uppercased()
            label.sizeToFit()
            return CGSize(width: label.frame.width, height: collectionView.frame.height - 10)
        }
        if collectionView == self.subCollectionView {
            let label = UILabel(frame: CGRect.zero)
            label.text = subArrays[indexPath.row].title.uppercased()
            label.sizeToFit()
            return CGSize(width: label.frame.width, height: subCollectionView.frame.height - 20)
        }
        if collectionView == self.listCollectionView {
            return CGSize(width: (listCollectionView.frame.width - 3) / 2, height: 290)
        } else {
            let label = UILabel(frame: CGRect.zero)
            label.text = selectedArrays[indexPath.item].title.uppercased()
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: selectedCollectionView.frame.height - 20)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.parentCollectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 28)
        }
        if collectionView == self.subCollectionView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 18)
        }
        if collectionView == self.listCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
    
}
extension HomeViewController:  DataCollectionProtocol {
    func removeCell(indx: Int) {
    selectedArrays.remove(at: indx)
    selectedCollectionView.reloadData()
        
    selectedSub.remove(at: indx)
    subCollectionView.reloadData()
    
    // MARK: - Change constraint
    view.layoutIfNeeded()
        if self.selectedArrays.count == 0 {
            self.topSeclectedView.constant = -45
            self.heightTopview.constant = 85
        } else {
            self.topSeclectedView.constant = 0
            self.heightTopview.constant = 130
        }

    UIView.animate(withDuration: 0.5
        , animations: {
            self.view.layoutIfNeeded()
    }, completion: nil)
    }
}


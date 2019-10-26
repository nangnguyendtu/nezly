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
    var parentArrays = [Category]()
    var subArrays = [Category]()
    var selectedArrays = [Category]()
    var selected = [Int]()
    var selectedSub = [Int]()
    //var selectedParent: Category?
    
    static let storyboadId = "HomeViewController"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    parentCollectionView.getCellFromNib(identifier: "CollectionViewCell")
    subCollectionView.getCellFromNib(identifier: "CollectionViewCell")
    listCollectionView.getCellFromNib(identifier: "AuctionCollectionViewCell")
    selectedCollectionView.getCellFromNib(identifier: "ListCollectionViewCell")
        
    containerView.layer.cornerRadius = 5
    searchTextField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    searchTextField.attributedPlaceholder = NSAttributedString(string: searchTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
    
    imageView()
        
    // MARK: - Loadjson
    loadJson(filename: "categories")

    }
    func imageView(){
        // MARK: - NavigationBar
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
            return 4
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if  collectionView == self.parentCollectionView {
            let cell = parentCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.nameLabel.text = parentArrays[indexPath.row].title.uppercased()
            // MARK:
            if let selectedParentId = selected.first {
                if parentArrays[indexPath.item].id == selectedParentId
                {
                    cell.nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                } else {
                    cell.nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                }
            }
            return cell
        }
        if  collectionView == self.subCollectionView {
            let cell = subCollectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.nameLabel.textColor = .gray
            cell.nameLabel.backgroundColor = .white
            cell.nameLabel.text = subArrays[indexPath.row].title.uppercased()
             // MARK:
                if selectedSub.contains(subArrays[indexPath.row].id)
                {
                    cell.nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
                } else {
                    cell.nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
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
        else if collectionView == self.subCollectionView{
            let sub = subArrays[indexPath.row]
            
            if let index = selectedArrays.firstIndex(where: { $0.id == sub.id }) {
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

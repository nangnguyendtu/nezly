//
//  PopupViewController.swift
//  Nezly
//
//  Created by Nguyen on 10/26/19.
//  Copyright © 2019 Nguyen. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {
    
    // MARK: -IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Variable
    var arrays = ["@username1: $6,350.0","@username1: $6,350.0","@username1: $6,350.0","@username1: $6,350.0"]
    
    static let storyboadId = "PopupViewController"
    
    // MARK: -View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        customProgressView()
        
        containerView.backgroundColor = UIColor(hex: 0x472E7D)
        submitButton.backgroundColor = UIColor(hex: 0x8863D5)
        
        containerView.layer.cornerRadius = 20
        cancelButton.layer.borderWidth = 1
        cancelButton.layer.borderColor = UIColor.white.cgColor
        
        tableView.getCellFromNib(identifier: "UserTableViewCell")
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: -IBAction
    @IBAction func cancelInfo(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submit(_ sender: Any) {
        let a = nameTextField.text!
        arrays.append("@username1:" + " $" + a)
        tableView.reloadData()
    }
    
    //hide and show keyboard
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    // MARK: -CustomProgressView
    func  customProgressView() {
        progressView.transform = progressView.transform.scaledBy(x: 1, y: 8)
        progressView.layer.cornerRadius = 10
        progressView.clipsToBounds = true
        progressView.layer.sublayers![1].cornerRadius = 10
        progressView.subviews[1].clipsToBounds = true
        progressView.tintColor = UIColor(hex: 0x8863D5)
    }
    
}

extension PopupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        cell.nameLabel.text = arrays[indexPath.row]
        cell.nameLabel.textColor = UIColor(hex: 0xD8D8D8)
        cell.selectionStyle = .none
        return cell
    }
    
}





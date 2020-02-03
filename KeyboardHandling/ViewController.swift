//
//  ViewController.swift
//  KeyboardHandling
//
//  Created by Christian Hurtado on 2/3/20.
//  Copyright © 2020 Christian Hurtado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var pursuitLogo: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var pursuitLogoCenterY: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterForKeyboardNotifications()
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        print("KeyboardWillShow")
        print(notification.userInfo)
        
        // UIKeyboardFrameBeginUserInfoKey
        
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
        }
        print("keyboard frame is \(keyboardFrame)")
    
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        print("KeyboardWillHide")
        print(notification.userInfo)
    }
    
    
    private func moveKeyboardUp(_ height: CGFloat) {
        pursuitLogoCenterY.constant -= height
    }

}


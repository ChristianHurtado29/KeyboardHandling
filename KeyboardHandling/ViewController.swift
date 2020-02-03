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
    
    private var originalYConstraint: NSLayoutConstraint!
    
    private var keyboardIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pulsateLogo()
        registerForKeyboardNotifications()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
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
        moveKeyboardUp(keyboardFrame.size.height)
    
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        
        // TODO: Complete
        resetUI()
        
        print("KeyboardWillHide")
        print(notification.userInfo)
    }
    
    
    private func moveKeyboardUp(_ height: CGFloat) {
        if keyboardIsVisible { return }
        originalYConstraint = pursuitLogoCenterY
        
        print("OriginalYConstraint: \(originalYConstraint.constant)")
        pursuitLogoCenterY.constant -= (height * 0.80)
        keyboardIsVisible = true
        
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 10.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func resetUI() {
        keyboardIsVisible = false
        // -314 = 0, +314
        print("OriginalYConstraint: \(originalYConstraint.constant)")
        pursuitLogoCenterY.constant -= originalYConstraint.constant
        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
    }
    
    
    private func pulsateLogo() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.pursuitLogo.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        }, completion: nil)
    }

}


extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    //    resetUI()
        return true
    }
}

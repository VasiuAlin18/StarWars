//
//  RegisterViewController.swift
//  StarWars
//
//  Created by Take Off Labs on 22.10.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var jediButton: UIButton!
    @IBOutlet weak var sithButton: UIButton!
    
    var avatar = "Jedi"
    
    @IBAction func avatarChanged(_ sender: UIButton) {
        jediButton.isSelected = false
        sithButton.isSelected = false
        
        sender.isSelected = true
        avatar = sender.currentTitle!
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let message = e.localizedDescription
                    let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    UserDefaults.standard.set(self.avatar, forKey: email)
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
        
        
    }
    
}

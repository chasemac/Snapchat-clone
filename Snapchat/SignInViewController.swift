//
//  SignInViewController.swift
//  Snapchat
//
//  Created by Chase McElroy on 2/24/17.
//  Copyright © 2017 Chase McElroy. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    
    @IBAction func turnUpTapped(_ sender: Any) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("we tried to sign in")
            if error != nil {
                print("hey we have an error: \(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("we tried to create user")
                    if error != nil {
                        print("hey we have an error: \(error)")
                        
                    } else {
                        print("Created user successfull")
                        
                        FIRDatabase.database().reference().child("users").child(user!.uid).child("email").setValue(user!.email)
                        
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }

                })
                
            } else {
                print("Signed in successfull")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
        
    }
    
}



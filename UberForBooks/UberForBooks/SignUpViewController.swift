//
//  SignUpViewController.swift
//  UberForBooks
//
//  Created by Rohan Ratnaparkhi on 6/28/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet var password: UITextField!
    @IBOutlet var showHideBtn: UIButton!
    
    @IBAction func toggleSignUpPasswordVisibility(){
        if self.password.secureTextEntry == true {
            self.password.secureTextEntry = false
            self.showHideBtn.setTitle("HIDE", forState: .Normal)
        } else {
            self.password.secureTextEntry = true
            self.showHideBtn.setTitle("SHOW", forState: .Normal)
        }
    }
    
    @IBAction func userSignUp(){
        
    }
    
}

//
//  LoginViewController.swift
//  UberForBooks
//
//  Created by Rohan Ratnaparkhi on 6/28/16.
//  Copyright © 2016 Talentica. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController{
    
    @IBOutlet var emailId: UITextField!
    @IBOutlet var userPassword: UITextField!
    @IBOutlet var errorMsg: UILabel!
    @IBOutlet var passwordToggle: UIButton!
    
    @IBAction func LoginWithCredentials(){
        
        if self.errorMsg.alpha == 1 {
            self.errorMsg.alpha = 0
        }
        
        guard let uName = self.emailId.text where uName != "" else {
            self.printLoginErrorMessage("Email Id is mandatory")
            return
        }
        
        guard let uPwd = self.userPassword.text where uPwd != "" else {
            self.printLoginErrorMessage("Password is mandatory")
            return
        }
        
        let params = [
            "username": uName,
            "password": uPwd
        ]
        
        Alamofire.request(.POST, baseAPI + loginUrl, parameters: params, encoding: .JSON)
            .responseJSON{ response in
                switch response.result{
                case .Success(let JSON):
//                    print("success json: \(JSON)")
                    let parsedJSON = JSON as! NSDictionary
                    if let msg = parsedJSON.objectForKey("message") where String(msg) != "Login successful" {
                        self.printLoginErrorMessage(String(msg))
                    } else {
                        self.loginSuccessful(parsedJSON)
                    }
                case .Failure(let error):
                    print("Problem with server: \(error)")
                }

            }
    }
    
    @IBAction func togglePasswordVisibility(){
        if self.userPassword.secureTextEntry == true {
            self.userPassword.secureTextEntry = false
            self.passwordToggle.setTitle("HIDE", forState: .Normal)
        } else {
            self.userPassword.secureTextEntry = true
            self.passwordToggle.setTitle("SHOW", forState: .Normal)
        }
        
    }
    
    @IBAction func dismissKeyboard(){
        emailId.resignFirstResponder()
        userPassword.resignFirstResponder()
    }
    
    func printLoginErrorMessage(msg: String){
        self.errorMsg.text = msg
        self.errorMsg.alpha = 1
    }
    
    func loginSuccessful(json: NSDictionary){
        userId = self.emailId.text!
        userPwd = self.userPassword.text!
        userToken = String(json.objectForKey("data"))
    }
    
}

//
//  LoginViewController.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 22/01/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import RVNetwork

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginWith(email: "8509729350", password: "Testing123!")
    }
    func loginWith(email: String, password: String) {
        let loginRequest = LoginRequest(email:email, password: password)
        let viewodel = LoginViewModel()
        viewodel.login(with: loginRequest)
    }
}

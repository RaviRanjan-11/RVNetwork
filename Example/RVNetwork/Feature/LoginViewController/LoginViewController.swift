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
        let parameter = LoginRequest(email:email, password: password)
        let task = RVHTTPTask.requestWithParameters(bodyEncoding: .jsonEncoding,bodyParameters: parameter)
        let loginRoute = LoginRoute(task: task)
        let networkService = RVServiceRouter()
        networkService.isLoggingEnable = true
        networkService.performDataTask(loginRoute) { (response: Result<LoginResponse, RVNetworkingError>) in
            switch response {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

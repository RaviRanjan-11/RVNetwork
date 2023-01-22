//
//  LoginViewModel.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 23/01/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import RVNetwork

protocol LoginViewModelProtocol {
    func login(with loginCredential: LoginRequest)
}

class LoginViewModel: LoginViewModelProtocol {
    
    private let networkService = RVServiceRouter.sharedServiceRouter

    func login(with loginCredential: LoginRequest) {
        let task = RVHTTPTask.requestWithParameters(bodyEncoding: .jsonEncoding,bodyParameters: loginCredential)
        let loginRoute = LoginRoute(task: task)
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

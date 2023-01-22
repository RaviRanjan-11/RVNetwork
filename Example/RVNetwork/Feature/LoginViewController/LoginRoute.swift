//
//  LoginRoute.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 23/01/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import RVNetwork
struct LoginRoute: RVNetworkRoute {
    init(task: RVNetwork.RVHTTPTask) {
        self.task = task
    }
    
    var baseURL: String {
        return "https://app.coachable-app.com/"
    }
    
    var path: String? {
        return "api/v1/signin"
    }
    
    var httpMethod: RVNetwork.RVHTTPMethod {
        return .post
    }
    
    var task: RVNetwork.RVHTTPTask
    
    var headers: RVNetwork.RVHTTPHeaders? = nil
    
    
}

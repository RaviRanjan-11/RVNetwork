//
//  PostRoute.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 22/01/23.
//  Copyright © 2022 r.ranjanchn@gmail.com. All rights reserved.
//

import Foundation
import RVNetwork
struct PostRoute: RVNetworkRoute {
    
    init(task: RVHTTPTask = .request) {
        self.task = task
    }
    var baseURL: String {
        return  "https://jsonplaceholder.typicode.com/"
    }
    
    var path: String? {
        return "posts"
    }
    
    var httpMethod: RVNetwork.RVHTTPMethod {
        return .get
    }
    
    var headers: RVNetwork.RVHTTPHeaders? {
        return nil
    }
    var task: RVNetwork.RVHTTPTask
    
}



//
//  PostRoute.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 22/01/23.
//  Copyright © 2022 r.ranjanchn@gmail.com. All rights reserved.
//

import Foundation
import RVNetwork
struct PostRoute: RVEndPoint {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/posts")!
    }
    
    var path: String? {
        return nil
    }
    
    var httpMethod: RVNetwork.RVHTTPMethod {
        return .get
    }
    
    var task: RVNetwork.RVHTTPTask {
        return .request
    }
    
    var headers: RVNetwork.HTTPHeaders? {
        return nil
    }
    
    
}



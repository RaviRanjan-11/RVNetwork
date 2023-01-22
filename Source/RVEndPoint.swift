//
//  RVEndPoint.swift
//  GreenBoxIP
//
//  Created by Ravi Ranjan (r.ranjanchn@gmail.com) on 07/10/22.
//  Copyright © 2022 GreenBoxIP. All rights reserved.
//

import Foundation

public protocol RVNetworkRoute {
    init(task: RVHTTPTask)
    var baseURL: String { get }
    var path: String? { get }
    var httpMethod: RVHTTPMethod { get }
    var task: RVHTTPTask { get }
    var headers: RVHTTPHeaders? { get }
}

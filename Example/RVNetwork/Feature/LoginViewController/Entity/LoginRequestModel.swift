//
//  LoginRequestModel.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 23/01/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
struct LoginRequest:Encodable {
    var email: String
    var password: String
}

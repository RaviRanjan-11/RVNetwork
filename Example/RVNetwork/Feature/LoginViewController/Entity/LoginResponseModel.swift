//
//  LoginResponseModel.swift
//  RVNetwork_Example
//
//  Created by Ravi Ranjan on 23/01/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
struct LoginResponse: Codable {
    
    let data: LoginData?
    let errorData: ErrorLoginData?
    let status: String?
    let statusCode: Int?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: LoginResponseCodingKeys.self)
        data =  try values.decodeIfPresent(LoginData.self, forKey: .data)
        errorData =  try values.decodeIfPresent(ErrorLoginData.self, forKey: .error)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)

    }
}
struct LoginData: Codable {
    let authToken: String?
    let userId: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: LoginDataCodingKeys.self)
        authToken = try values.decodeIfPresent(String.self, forKey: .authToken)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }
}

struct ErrorLoginData: Codable {
    let code: String?
    let message: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ErrorLoginDataCodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
enum LoginResponseCodingKeys: String, CodingKey {
    case data
    case status
    case error
    case statusCode
}

enum LoginDataCodingKeys: String, CodingKey {
    case authToken
    case userId
}

enum ErrorLoginDataCodingKeys: String, CodingKey {
    case code
    case message
}


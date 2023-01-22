//
//  RVHTTPMethod.swift
//  GreenBoxIP
//
//  Created by Ravi Ranjan (r.ranjanchn@gmail.com) on 07/10/22.
//  Copyright © 2022 GreenBoxIP. All rights reserved.
//

import Foundation
public enum RVHTTPMethod {
    case get
    case post
    case put
    case delete
}
extension RVHTTPMethod: RawRepresentable {
    public typealias RawValue = String
    public init?(rawValue: RawValue) {
        switch rawValue {
        case "G": self = .get
        case "P": self = .post
        case "PU": self = .put
        case "D": self = .delete
        default: return nil
        }
    }
    public var rawValue: RawValue {
        switch self {
        case .get: return "get"
        case .post: return "post"
        case .put: return "put"
        case .delete: return "delete"
        }
    }
}

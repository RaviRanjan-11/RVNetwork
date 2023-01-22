//
//  RVNetworkingError.swift
//  GreenBoxIP
//
//  Created by Ravi Ranjan (r.ranjanchn@gmail.com) on 07/10/22.
//  Copyright © 2022 GreenBoxIP. All rights reserved.
//

import Foundation
protocol RVErrorDescription {
    var errorMessage: String { get }
}
public enum RVNetworkingError: Error {
    case networkError
    case urlResponseError
    case decodingError
    case dataError
}


extension RVNetworkingError: RVErrorDescription {
     public var errorMessage: String {
        switch self {
        case.decodingError:
            return "Error in decoding Response Data"
        case .dataError:
            return "Response data is empty"
        case .urlResponseError:
            return "Error in url response"
        case .networkError:
            return "Error in network connection"
        }
    }
}

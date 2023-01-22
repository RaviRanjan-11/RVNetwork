//
//  RVJSONParameterEncoder.swift
//  GreenBoxIP
//
//  Created by Ravi Ranjan (r.ranjanchn@gmail.com) on 07/10/22.
//  Copyright © 2022 GreenBoxIP. All rights reserved.
//

import Foundation

public struct RVJSONParameterEncoder: RVParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONEncoder().encode(parameters)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw RVNetworkingError.decodingError
        }
    }
}


//
//  RVParameterEncoding.swift
//  GreenBoxIP
//
//  Created by Ravi Ranjan (r.ranjanchn@gmail.com) on 07/10/22.
//  Copyright © 2022 GreenBoxIP. All rights reserved.
//
import Foundation

public typealias Parameters = Encodable

public protocol RVParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum RVParameterEncoding {
    
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try RVURLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try RVJSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try RVURLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try RVJSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            }
        }catch {
            throw error
        }
    }
}

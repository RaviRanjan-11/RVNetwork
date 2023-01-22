//
//  RVURLParameterEncoder.swift
//  GreenBoxIP
//
//  Created by Ravi Ranjan (r.ranjanchn@gmail.com) on 07/10/22.
//  Copyright © 2022 GreenBoxIP. All rights reserved.
//

import Foundation

public struct RVURLParameterEncoder: RVParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw RVNetworkingError.inValidURLError }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false) {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            
            let mirror = Mirror(reflecting: parameters)
            
            for child in mirror.children {
                let queryItem = URLQueryItem(name: child.label ?? "",
                                             value: "\(child.value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}

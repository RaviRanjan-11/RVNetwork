//
//  RVNetworkLogger.swift
//  GreenBoxIP
//
//  Created by Ravi Ranjan (r.ranjanchn@gmail.com) on 07/10/22.
//  Copyright © 2022 GreenBoxIP. All rights reserved.
//

import Foundation

class RVNetworkLogger {
    
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        print("URL : \(urlAsString)")
        print("Path : \(path)")
        print("Query : \(query)")
        print("Method : \(method)")
        print("HOST: \(host)")
        var logOutput = ""
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(response: HTTPURLResponse) {
        print("\n - - - - - - - - - - Incoming - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        print("Status code: \(response.statusCode) \n")
//        print("Description : \(response.description) \n \n")
        
    }
}

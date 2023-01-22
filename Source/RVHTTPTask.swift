//
//  RVHTTPTask.swift
//  GreenBoxIP
//
//  Created by Ravi Ranjan (r.ranjanchn@gmail.com) on 07/10/22.
//  Copyright © 2022 GreenBoxIP. All rights reserved.
//

import Foundation

public typealias RVHTTPHeaders = [String:String]

public enum RVHTTPTask {
    case request
    
    case withParameters(encoding: RVParameterEncoding, bodyParameters: Parameters? = nil, urlParameters: Parameters? = nil)
    
    case withParametersAndHeaders(encoding: RVParameterEncoding,
        urlParameters: Parameters? = nil,
        bodyParameters: Parameters? = nil,
        additionHeaders: RVHTTPHeaders? = nil)
    
    // case download, upload...etc
}



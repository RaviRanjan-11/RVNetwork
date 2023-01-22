//
//  RVNetworkRequestType.swift
//  GreenBoXIP
//
//  Created by Ravi Ranjan on 07/10/22.
//  Copyright © 2022 r.ranjanchn@gmail.com. All rights reserved.
//

import Foundation


protocol RVServiceNetworkRouter: AnyObject {
    func performDataTask<T: Decodable>(_ route: RVNetworkRoute, completionHandler: @escaping(Result<T, RVNetworkingError>) -> Void)
    func cancel()
}

public class RVServiceRouter: RVServiceNetworkRouter {
    
    public var isLoggingEnable: Bool = false
    public static let sharedServiceRouter = RVServiceRouter()
    public init(){}
    private var task: URLSessionTask?
    
    public func performDataTask<T: Decodable>(_ route: RVNetworkRoute, completionHandler: @escaping(Result<T, RVNetworkingError>) -> Void) {
        
        do {
            let urlRequest = try self.buildRequest(from: route)
            
            if self.isLoggingEnable {
                RVNetworkLogger.log(request: urlRequest)
            }
            
            task =  URLSession.shared.dataTask(with: urlRequest) { responseData, urlResponse, error in
                guard error == nil else {
                    completionHandler(.failure(.networkError))
                    return
                }
                
                guard let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                    completionHandler(.failure(.urlResponseError))
                    return
                }
                
                if self.isLoggingEnable {
                    RVNetworkLogger.log(response: urlResponse)
                }
                
                guard let responseData = responseData , responseData.count > 0 else {
                    completionHandler(.failure(.dataError))
                    return
                }
                
                if self.isLoggingEnable {
                    RVNetworkLogger.log(response: responseData)
                }
                
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData)
                    completionHandler(.success(result))
                    
                } catch {
                    debugPrint("error occured while decoding = \(error.localizedDescription)")
                    completionHandler(.failure(.decodingError))
                }
                
            }
        }catch {
            completionHandler(.failure(.networkError))
        }
        self.task?.resume()
    }
    
    public func cancel() {
        self.task?.cancel()
    }
    
    
    private func buildRequest(from route: RVNetworkRoute) throws -> URLRequest {
        
        guard let baseURL = URL(string: route.baseURL) else{
            throw RVNetworkingError.inValidURLError
        }
        
        var request = URLRequest(url: baseURL.appendingPathComponent(route.path ?? ""),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestWithParameters(let bodyEncoding, let bodyParameter,
                                        let urlParameters):
                
                try self.configureParameters(bodyEncoding: bodyEncoding, bodyParameters: bodyParameter, urlParameters: urlParameters, request: &request)
                
            case .requestParametersAndHeaders(let bodyEncoding, let bodyParameter,
                                              let urlParameters, let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                
                try self.configureParameters(bodyEncoding: bodyEncoding, bodyParameters: bodyParameter, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    private func configureParameters(bodyEncoding: RVParameterEncoding,
                                         bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    private func addAdditionalHeaders(_ additionalHeaders: RVHTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}



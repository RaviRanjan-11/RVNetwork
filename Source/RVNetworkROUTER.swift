//
//  RVNetworkRequestType.swift
//  GreenBoXIP
//
//  Created by Ravi Ranjan on 07/10/22.
//  Copyright © 2022 r.ranjanchn@gmail.com. All rights reserved.
//

import Foundation


protocol RVServiceNetworkRouter: AnyObject {
//    associatedtype EndPoint: EndPointType
    func performDataTask<T: Decodable>(_ route: RVEndPoint, completionHandler: @escaping(Result<T, RVNetworkingError>) -> Void)
    func cancel()
}

public class RVServiceRouter: RVServiceNetworkRouter {
    
    public init(){}
    private var task: URLSessionTask?
    
    public func performDataTask<T: Decodable>(_ route: RVEndPoint, completionHandler: @escaping(Result<T, RVNetworkingError>) -> Void) {
        
        do {
            let urlRequest = try self.buildRequest(from: route)
            RVNetworkLogger.log(request: urlRequest)
            
            
            task =  URLSession.shared.dataTask(with: urlRequest) { responseData, urlResponse, error in
                guard error == nil else {
                    completionHandler(.failure(.networkError))
                    return
                }
                
                guard let urlResponse = urlResponse as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                    completionHandler(.failure(.urlResponseError))
                    return
                }
                RVNetworkLogger.log(response: urlResponse)

                guard let responseData = responseData , responseData.count > 0 else {
                    completionHandler(.failure(.dataError))
                    return
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
    
    
    private func buildRequest(from route: RVEndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path ?? ""),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestWithParameters(let bodyParameters,
                                        let bodyEncoding,
                                        let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: RVParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}

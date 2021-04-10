//
//  NetworkLogger.swift
//  BaseMVVM
//
//  Created by Hoang Hai on 10/04/2021.
//  Copyright © 2021 TonyHoang. All rights reserved.
//

import Alamofire

public struct NetworkLogger {
    public static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = urlComponents?.path ?? ""
        let query = urlComponents?.query ?? ""
        let host = urlComponents?.host ?? ""
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    public static func log(_ request: DataRequest) {
        request.responseJSON { response in
            print("\n++++++++++++++++++++++++++++ RESPONSE ++++++++++++++++++++++++++++++++ \n")
                
            if let statusCode = response.response?.statusCode {
                print("Status Code: \(statusCode)\n")
            }
            
            guard let dict = parseToDict(response.data) else {
                print("Unable to parse response data!!!\n")
                return
            }
            
            switch response.result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print("RESPONSE: \(dict.description)\n")
                print(error)
            }
            
            print("\n++++++++++++++++++++++++++++++++ END ++++++++++++++++++++++++++++++++++ \n")
        }
    }
    
    public static func log(_ urlRequest: URLRequest?) {
        print("\n++++++++++++++++++++++++++++ OUTGOING ++++++++++++++++++++++++++++++++ \n")
        
        if let urlStr = urlRequest?.url?.absoluteString {
            print("URL: \(urlStr)\n")
        }
        
        if let method = urlRequest?.httpMethod {
            print("METHOD: \(method)\n")
        }
        
        if let headers = urlRequest?.allHTTPHeaderFields {
            print("HEADERS: \(headers)\n")
        }
        
        if let jsonBody = urlRequest?.httpBody, let jsonStr = String(data: jsonBody, encoding: .utf8) {
            print("JSON: \(jsonStr)")
        }

        print("\n++++++++++++++++++++++++++++++++ END ++++++++++++++++++++++++++++++++++ \n")
    }
    
    public static func logDecrypt(_ request: DataRequest) {
        request.responseJSON { response in
            print("\n++++++++++++++++++++++++++++ RESPONSE ++++++++++++++++++++++++++++++++ \n")
                
            if let statusCode = response.response?.statusCode {
                print("Status Code: \(statusCode)\n")
            }
            
            switch response.result {
            case .success:
                if let dict = parseToDict(response.data) {
                    print(dict)
                }
            case .failure(let error):
                print(error)
            }
            
            print("\n++++++++++++++++++++++++++++++++ END ++++++++++++++++++++++++++++++++++ \n")
        }
    }
    
    public static func parseToDict(_ data: Data?) -> [String: Any]? {
        if let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let dict = json as? [String: Any] {
            return dict
        }
        return nil
    }
    
}

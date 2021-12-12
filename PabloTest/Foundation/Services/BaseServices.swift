//
//  BaseServices.swift
//  PabloTest
//
//  Created by Pablo Duarte on 10/12/21.
//

import UIKit

class BaseServices: NSObject {
    
    typealias CompletionBlock = (Any?, Error?) -> ()
    
    //MARK: Static functions
    static func requestGET<T: Decodable>(url: String, responseType: T.Type, completion: @escaping CompletionBlock) {
        return request(url: url, responseType: responseType, completion: completion)
    }
}

//MARK:- Private functions
private extension BaseServices {
    static func request<T: Decodable>(url: String, responseType: T.Type, completion: @escaping CompletionBlock) {
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        let urlString = buildUrl(with: url)
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return
        }
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            guard error == nil,
                  let data = data else {
                completion(nil, error)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(responseType.self, from: data)
                completion(response, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }

    static func buildUrl(with path: String) -> String {
        return AppConstants.Url.baseUrl + path
    }
}

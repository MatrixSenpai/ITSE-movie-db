//
//  API.swift
//  ITSE-movie-db
//
//  Created by Mason Phillips on 4/14/22.
//

import Foundation

protocol APIRequest {
    associatedtype Result: Decodable
}

class API {
    public static let shared: API = API()
    
    private init() {
        
    }
    
    private func request<T: APIRequest>(_ request: T, callback: @escaping ((T.Result?, Error?) -> Void)) {
        
    }
    
    private func build<T: APIRequest>(_ request: T) -> URLRequest {
        return URLRequest(url: URL(string: "")!)
    }
}

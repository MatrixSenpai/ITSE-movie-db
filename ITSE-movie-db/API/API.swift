//
//  API.swift
//  ITSE-movie-db
//
//  Created by Mason Phillips on 4/14/22.
//

import Foundation

protocol APIRequest {
    associatedtype Result: Decodable
    
    var endpoint: String                     { get }
    var method  : HTTPMethod                 { get }
    var params  : Dictionary<String, String> { get }
}

struct APIResponseWrapped<T: Decodable>: Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    
    let results: Array<T>
}

enum HTTPMethod: String {
    case GET, POST
}

class API {
    public static let shared: API = API()
    
    public static let baseURL: URL = URL(string: "https://api.themoviedb.org/3")!
    
    private let api_key: String = ProcessInfo.processInfo.environment["api_key"] ?? "NOAPIKEY"
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    enum APIError: Error {
        case noResponse
    }
    
    private init() {}
    
    func request<T: APIRequest>(_ request: T, callback: @escaping ((T.Result?, Error?) -> Void)) {
        let url_request = self.build(request)
        let task = session.dataTask(with: url_request) { data, response, error in
            if let data = data {
                do {
                    let json = try self.decoder.decode(T.Result.self, from: data)
                    callback(json, nil)
                } catch {
                    callback(nil, error)
                }
            } else if let error = error {
                callback(nil, error)
            } else {
                callback(nil, APIError.noResponse)
            }
        }
        task.resume()
    }
    
    private func build<T: APIRequest>(_ request: T) -> URLRequest {
        let url = Self.baseURL.appendingPathComponent(request.endpoint)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        components.queryItems = request.params.map { (k, v) -> URLQueryItem in
            URLQueryItem(name: k, value: v)
        }
        components.queryItems!.append(URLQueryItem(name: "api_key", value: self.api_key))
        
        return URLRequest(url: components.url!)
    }
}

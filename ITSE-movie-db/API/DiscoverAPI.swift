//
//  DiscoverAPI.swift
//  ITSE-movie-db
//
//  Created by Mason Phillips on 4/21/22.
//

import Foundation

private struct DiscoverMovieRequest: APIRequest {
    typealias Result = APIResponseWrapped<DiscoverMovieResponse>
    
    var endpoint: String                   { "/discover/movie" }
    var method: HTTPMethod                 { .GET }
    var params: Dictionary<String, String> { [:] }
    
}
//private struct 

extension API {
    func getDiscoverMovies(_ callback: @escaping (APIResponseWrapped<DiscoverMovieResponse>?, Error?) -> Void) {
        let request = DiscoverMovieRequest()
        self.request(request, callback: callback)
    }
}

struct DiscoverMovieResponse: Decodable {
    let poster_path: String?
    let adult: Bool
    let overview: String
    let release_date: String
    let genre_ids: Array<Int>
    let id: Int
    let original_title: String
    let original_language: String
    let title: String
    let backdrop_path: String?
    let popularity: Float
    let vote_count: Int
    let video: Bool
    let vote_average: Float
}
struct DiscoverShowResponse: Decodable {
    let poster_path: String?
    let popularity: Float
    let id: Int
    let backdrop_path: String?
    let vote_average: Float
    let overview: String
    let first_air_date: String
    let origin_country: Array<String>
    let genre_ids: Array<Int>
    let original_language: String
    let vote_count: Int
    let name: String
    let original_name: String
}

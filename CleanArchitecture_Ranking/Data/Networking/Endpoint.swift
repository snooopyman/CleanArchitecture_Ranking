//
//  Endpoint.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

struct Endpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?
    
    init(path: String, method: HTTPMethod, headers: [String: String]? = nil, body: Data? = nil) {
        self.path = path
        self.method = method
        self.headers = headers
        self.body = body
    }
}

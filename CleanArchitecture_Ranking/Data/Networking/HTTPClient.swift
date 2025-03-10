//
//  HTTPClient.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

import Foundation

protocol HTTPClient: Sendable {
    func makeRequest(endpoint: Endpoint, baseUrl: String) async -> Result<Data, HTTPClientError>
}

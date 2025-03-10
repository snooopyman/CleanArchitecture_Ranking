//
//  APIDataSourceType.swift
//  CleanArchitecture_Ranking
//
//  Created by Armando Cáceres on 28/2/25.
//

protocol APIDataSourceType: Sendable {
    func login() async -> Result<LoginDTO, HTTPClientError>
}

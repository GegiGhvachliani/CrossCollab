//
//  NetworkServiceProtocol.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 22.12.25.
//

import Foundation

protocol NetworkServiceProtocol {
    
    func request<T: Codable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T
    

    func requestWithoutResponse(
        endpoint: APIEndpoint
    ) async throws
}

//
//  NetworkError.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case unauthorized            
    case unknown
}

// MARK: - User-Friendly Messages
extension NetworkError {
    var message: String {
        switch self {
        case .invalidURL:
            return "Invalid request URL"
        case .noData:
            return "No data received from server"
        case .decodingError:
            return "Failed to process server response"
        case .serverError(let code):
            return "Server error: \(code)"
        case .unauthorized:
            return "Session expired. Please login again"
        case .unknown:
            return "An unexpected error occurred"
        }
    }
}

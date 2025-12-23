//
//  NetworkService.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

class NetworkService: NetworkServiceProtocol {
    
    private let keychainManager: KeychainManager
    
    private let useMockData = true //TODO: - shesacvlelia roca back mekneba
    
    init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
    }
    
    // MARK: - Request with Response
    func request<T: Codable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T {
        
        if useMockData {
            return try await mockResponse(for: endpoint, responseType: responseType)
        }
        
        guard let url = endpoint.buildURL() else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = keychainManager.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
            
        case 401:
            throw NetworkError.unauthorized
            
        case 400...599:
            throw NetworkError.serverError(httpResponse.statusCode)
            
        default:
            throw NetworkError.unknown
        }
        
        guard !data.isEmpty else {
            throw NetworkError.noData
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("❌ Decoding error: \(error)")
            if let json = String(data: data, encoding: .utf8) {
                print("📦 Response JSON: \(json)")
            }
            throw NetworkError.decodingError
        }
    }
    
    // MARK: - Request without Response
    func requestWithoutResponse(
        endpoint: APIEndpoint
    ) async throws {
        
        guard let url = endpoint.buildURL() else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = keychainManager.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return
            
        case 401:
            throw NetworkError.unauthorized
            
        case 400...599:
            throw NetworkError.serverError(httpResponse.statusCode)
            
        default:
            throw NetworkError.unknown
        }
    }
    
    
    
    // MARK: - MOCK data for testing
    
    private func mockResponse<T: Codable>(
        for endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T {
        
        try await Task.sleep(nanoseconds: 1_000_000_000)  // 1 second
        
        switch endpoint {
            // MARK: Login Mock
        case .login(let email, let password):
            print("🟢 MOCK: Login called with email: \(email)")
            
            // Check credentials
            if email == "test@test.com" && password == "password" {
                let mockResponse = AuthResponse(
                    token: "mock_jwt_token_12345",
                    userId: 1,
                    fullName: "Test User",
                    role: "Employee",
                    expiresAt: "2025-12-31T23:59:59Z"
                )
                return mockResponse as! T
            } else {
                throw NetworkError.serverError(401)
            }
            
            // MARK: Register Mock
        case .register(let email, let password, let fullName):
            print("🟢 MOCK: Register called")
            
            let mockResponse = AuthResponse(
                token: "mock_jwt_token_new_user",
                userId: 2,
                fullName: fullName,
                role: "Employee",
                expiresAt: "2025-12-31T23:59:59Z"
            )
            return mockResponse as! T
            
            // MARK: Forgot Password Mock
        case .forgotPassword(let email):
            print("🟢 MOCK: Forgot password called for: \(email)")
            
            let mockResponse = ["message": "Password reset link sent"]
            return mockResponse as! T
            
            // MARK: Get Events Mock
        case .getEvents:
            print("🟢 MOCK: Get events called")
            
            let mockEvents = [
                Event(
                    id: 101,
                    title: "Team Building Retreat",
                    description: "Two-day offsite for cross-team bonding",
                    eventTypeName: "Team Building",
                    startDateTime: "2025-02-05T09:00:00Z",
                    endDateTime: "2025-02-06T18:00:00Z",
                    location: "Gudauri",
                    capacity: 30,
                    confirmedCount: 27,
                    waitlistedCount: 0,
                    isFull: false,
                    imageUrl: "https://picsum.photos/400/300",
                    tags: ["outdoor", "team-building"],
                    createdBy: "HR Team"
                ),
                Event(
                    id: 102,
                    title: "iOS Workshop",
                    description: "Learn Swift and SwiftUI",
                    eventTypeName: "Workshop",
                    startDateTime: "2025-02-10T14:00:00Z",
                    endDateTime: "2025-02-10T18:00:00Z",
                    location: "Tech Hub Tbilisi",
                    capacity: 20,
                    confirmedCount: 20,
                    waitlistedCount: 5,
                    isFull: true,
                    imageUrl: "https://picsum.photos/400/301",
                    tags: ["tech", "education"],
                    createdBy: "Tech Team"
                )
            ]
            return mockEvents as! T
            // MARK: - Get Event Detail Mock
        case .getEventDetail(let id):
            print("🟢 MOCK: Get event detail for id: \(id)")
            
            let mockEvents = [
                Event(
                    id: 101,
                    title: "Team Building Retreat",
                    description: "Two-day offsite for cross-team bonding. Join us for engaging activities, team challenges, and networking opportunities in the beautiful mountains of Gudauri.",
                    eventTypeName: "Team Building",
                    startDateTime: "2025-02-05T09:00:00Z",
                    endDateTime: "2025-02-06T18:00:00Z",
                    location: "Gudauri Mountain Resort",
                    capacity: 30,
                    confirmedCount: 27,
                    waitlistedCount: 0,
                    isFull: false,
                    imageUrl: "https://picsum.photos/400/300",
                    tags: ["outdoor", "team-building", "networking"],
                    createdBy: "HR Team"
                ),
                Event(
                    id: 102,
                    title: "iOS Workshop",
                    description: "Learn Swift and SwiftUI basics. Perfect for beginners who want to start iOS development. Covers fundamentals and hands-on projects.",
                    eventTypeName: "Workshop",
                    startDateTime: "2025-02-10T14:00:00Z",
                    endDateTime: "2025-02-10T18:00:00Z",
                    location: "Tech Hub Tbilisi",
                    capacity: 20,
                    confirmedCount: 20,
                    waitlistedCount: 5,
                    isFull: true,
                    imageUrl: "https://picsum.photos/400/301",
                    tags: ["tech", "education", "ios"],
                    createdBy: "Tech Team"
                )
            ]
            
            if let event = mockEvents.first(where: { $0.id == id }) {
                return event as! T
            } else {
                throw NetworkError.serverError(404)
            }
            // MARK: Other endpoints - return empty/default
        default:
            print("🟡 MOCK: Endpoint not implemented yet: \(endpoint)")
            throw NetworkError.serverError(404)
        }
    }
}

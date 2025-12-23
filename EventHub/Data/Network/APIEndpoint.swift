//
//  APIEndpoint.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum APIEndpoint {
    // MARK: - Authentication
    case login(email: String, password: String)
    case register(email: String, password: String, fullName: String)
    case forgotPassword(email: String)
    
    // MARK: - Events
    case getEvents(eventTypeId: String?, location: String?, searchKeyword: String?, startDate: String?, endDate: String?, onlyAvailable: Bool?)
    case getEventDetail(id: Int)
    
    // MARK: - Registration
    case registerForEvent(eventId: Int, userId: Int)
    case cancelRegistration(registrationId: Int)
    case getUserRegistrations(userId: Int)
    
    // MARK: - Notifications
    case getNotifications
}

// MARK: - Endpoint Configuration
extension APIEndpoint {
    
    var baseURL: String {
        return "https://api.company.com"
    }
    
    var path: String {
        switch self {

        case .login:
            return "/api/auth/login"
        case .register:
            return "/api/auth/register"
        case .forgotPassword:
            return "/api/auth/forgot-password"
            
        case .getEvents:
            return "/api/events"
        case .getEventDetail(let id):
            return "/api/events/\(id)"
            
        case .registerForEvent:
            return "/api/registrations"
        case .cancelRegistration(let registrationId):
            return "/api/registrations/\(registrationId)"
        case .getUserRegistrations(let userId):
            return "/api/registrations/user/\(userId)"
            
        case .getNotifications:
            return "/api/notifications"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .register, .forgotPassword, .registerForEvent:
            return .post
            
        case .getEvents, .getEventDetail, .getUserRegistrations, .getNotifications:
            return .get
            
        case .cancelRegistration:
            return .delete
        }
    }
    
    var queryParameters: [String: String]? {
        switch self {
        case .getEvents(let eventTypeId, let location, let searchKeyword, let startDate, let endDate, let onlyAvailable):
            var params: [String: String] = [:]
            
            if let eventTypeId = eventTypeId {
                params["eventTypeId"] = eventTypeId
            }
            if let location = location {
                params["location"] = location
            }
            if let searchKeyword = searchKeyword {
                params["searchKeyword"] = searchKeyword
            }
            if let startDate = startDate {
                params["startDate"] = startDate
            }
            if let endDate = endDate {
                params["endDate"] = endDate
            }
            if let onlyAvailable = onlyAvailable {
                params["onlyAvailable"] = String(onlyAvailable)
            }
            
            return params.isEmpty ? nil : params
            
        default:
            return nil
        }
    }
    
    var body: [String: Any]? {
        switch self {
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
            
        case .register(let email, let password, let fullName):
            return [
                "email": email,
                "password": password,
                "fullName": fullName
            ]
            
        case .forgotPassword(let email):
            return [
                "email": email
            ]
            
        case .registerForEvent(let eventId, let userId):
            return [
                "eventId": eventId,
                "userId": userId
            ]
            
        default:
            return nil
        }
    }
    
    func buildURL() -> URL? {
        guard var components = URLComponents(string: baseURL + path) else {
            return nil
        }
        
        if let queryParameters = queryParameters {
            components.queryItems = queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            }
        }
        
        return components.url
    }
}

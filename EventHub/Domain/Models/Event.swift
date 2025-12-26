//
//  Event.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

struct Event: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let eventTypeName: String
    let startDateTime: String
    let endDateTime: String?
    let location: String
    let capacity: Int
    let confirmedCount: Int
    let waitlistedCount: Int?
    let imageUrl: String?
    let organizerName: String?
    let tags: [String]?
    let isActive: Bool?
    
    var isFull: Bool {
        confirmedCount >= capacity
    }
    
    var spotsLeft: Int {
        max(0, capacity - confirmedCount)
    }
}

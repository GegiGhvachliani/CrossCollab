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
    let endDateTime: String?  // Optional - backend doesn't always send
    let location: String
    let capacity: Int
    let confirmedCount: Int
    let waitlistedCount: Int?  // Optional - backend doesn't always send
    let imageUrl: String?
    let organizerName: String?  // Optional - backend doesn't always send
    let tags: [String]?
    let isActive: Bool?  // Optional - backend doesn't always send (they send isFull instead)
    
    var isFull: Bool {
        confirmedCount >= capacity
    }
    
    var spotsLeft: Int {
        max(0, capacity - confirmedCount)
    }
}

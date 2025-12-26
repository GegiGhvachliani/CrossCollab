//
//  Registration.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 24.12.25.
//

import Foundation

struct Registration: Identifiable, Codable, Hashable {
    let registrationId: Int
    let eventId: Int
    let eventTitle: String
    let eventType: String
    let startDateTime: String
    let location: String
    let status: String
    let registeredAt: String
    let eventIsActive: Bool
    let eventMessage: String?
    
    var id: Int { registrationId }
    
    var isConfirmed: Bool {
        status == "Confirmed"
    }
    
    var isWaitlisted: Bool {
        status == "Waitlisted"
    }
    
    var isCancelled: Bool {
        status == "Cancelled"
    }
}

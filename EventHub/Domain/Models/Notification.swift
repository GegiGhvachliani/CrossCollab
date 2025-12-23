//
//  Notification.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

struct Notification: Identifiable, Codable {
    let id: Int
    let type: String
    let title: String
    let message: String
    let eventId: Int?
    let createdAt: String
    let isRead: Bool
}

//
//
//  AuthRepositoryProtocol.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

protocol NotificationRepositoryProtocol {

    func getNotifications() async throws -> [Notification]
    func markAsRead(id: Int) async throws
}

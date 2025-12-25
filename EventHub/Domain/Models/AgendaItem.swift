//
//  AgendaItem.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 25.12.25.
//

import Foundation

struct AgendaItem: Identifiable, Hashable {
    let id: String
    let time: String
    let title: String
    let description: String?
    let duration: String
}

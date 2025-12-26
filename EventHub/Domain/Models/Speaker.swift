//
//  Speaker.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 25.12.25.
//

import Foundation

struct Speaker: Identifiable, Hashable {
    let id: String
    let name: String
    let title: String
    let bio: String?
    let imageUrl: String
    let company: String?
}

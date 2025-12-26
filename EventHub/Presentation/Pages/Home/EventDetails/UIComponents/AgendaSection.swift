//
//  AgendaSection.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 25.12.25.
//

import SwiftUI

struct AgendaSection: View {
    let items: [AgendaItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Agenda")
                .font(.system(size: 18, weight: .semibold))
            
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                let isLast = index == items.count - 1
                
                HStack(alignment: .top, spacing: 12) {
                    VStack {
                        ZStack {
                            Circle()
                                .fill(Color(.systemGray6))
                                .frame(width: 28, height: 28)
                            
                            Text("\(index + 1)")
                                .font(.system(size: 12, weight: .semibold))
                        }
                        
                        if !isLast {
                            Rectangle()
                                .fill(Color(.systemGray5))
                                .frame(width: 1)
                                .frame(maxHeight: .infinity)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(item.time)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.blue)
                            
                            Text("•")
                                .foregroundColor(.secondary)
                            
                            Text(item.duration)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }
                        
                        Text(item.title)
                            .font(.system(size: 14, weight: .semibold))
                        
                        if let description = item.description {
                            Text(description)
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .frame(minHeight: isLast ? 10 : 80)
            }
        }
        .padding(.horizontal)
    }
}

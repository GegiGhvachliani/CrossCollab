//
//  MockData.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 25.12.25.
//

import Foundation

struct MockData {
    
    // MARK: - Mock Events
    static let events: [Event] = [
        Event(
            id: 101,
            title: "iOS Development Workshop",
            description: "Learn advanced iOS development techniques with SwiftUI and Combine framework. Perfect for intermediate developers.",
            eventTypeName: "Workshop",
            startDateTime: "2025-12-28T10:00:00Z",
            endDateTime: "2025-12-28T16:00:00Z",
            location: "TBC Academy, Tbilisi",
            capacity: 30,
            confirmedCount: 22,
            waitlistedCount: 5,
            imageUrl: "https://picsum.photos/seed/ios-workshop/800/400",
            organizerName: "Tech Team",
            tags: ["iOS", "SwiftUI", "Development"],
            isActive: true
        ),
        Event(
            id: 102,
            title: "Team Building Adventure",
            description: "Outdoor team building activities including hiking and team challenges.",
            eventTypeName: "Team Building",
            startDateTime: "2025-12-30T09:00:00Z",
            endDateTime: "2025-12-30T18:00:00Z",
            location: "Mtatsminda Park",
            capacity: 50,
            confirmedCount: 50,
            waitlistedCount: 8,
            imageUrl: "https://picsum.photos/seed/team-building/800/400",
            organizerName: "HR Department",
            tags: ["Team", "Outdoor", "Fun"],
            isActive: true
        ),
        Event(
            id: 103,
            title: "Annual Company Conference",
            description: "Join us for keynote speakers, product launches, and networking.",
            eventTypeName: "Conference",
            startDateTime: "2026-01-15T09:00:00Z",
            endDateTime: "2026-01-15T17:00:00Z",
            location: "Radisson Blu Iveria Hotel",
            capacity: 200,
            confirmedCount: 145,
            waitlistedCount: 12,
            imageUrl: "https://picsum.photos/seed/conference/800/400",
            organizerName: "Executive Team",
            tags: ["Conference", "Networking"],
            isActive: true
        ),
        Event(
            id: 104,
            title: "Machine Learning Training",
            description: "Comprehensive training on ML fundamentals and practical applications.",
            eventTypeName: "Training",
            startDateTime: "2026-01-10T10:00:00Z",
            endDateTime: "2026-01-10T15:00:00Z",
            location: "TBC Academy, Room 301",
            capacity: 25,
            confirmedCount: 18,
            waitlistedCount: 3,
            imageUrl: "https://picsum.photos/seed/ml-training/800/400",
            organizerName: "Data Science Team",
            tags: ["ML", "AI", "Training"],
            isActive: true
        ),
        Event(
            id: 105,
            title: "New Year Celebration",
            description: "Celebrate the new year with colleagues! Dinner, music, entertainment.",
            eventTypeName: "Social",
            startDateTime: "2025-12-31T19:00:00Z",
            endDateTime: "2026-01-01T01:00:00Z",
            location: "Fabrika Tbilisi",
            capacity: 100,
            confirmedCount: 87,
            waitlistedCount: 0,
            imageUrl: "https://picsum.photos/seed/new-year/800/400",
            organizerName: "Social Committee",
            tags: ["Party", "Celebration"],
            isActive: true
        )
    ]
    
    // MARK: - Mock Registrations
    static let myRegistrations: [Registration] = [
        Registration(
            registrationId: 501,
            eventId: 101,
            eventTitle: "iOS Development Workshop",
            eventType: "Workshop",
            startDateTime: "2025-12-28T10:00:00Z",
            location: "TBC Academy, Tbilisi",
            status: "Confirmed",
            registeredAt: "2025-12-20T14:30:00Z",
            eventIsActive: true,
            eventMessage: nil
        ),
        Registration(
            registrationId: 502,
            eventId: 102,
            eventTitle: "Team Building Adventure",
            eventType: "Team Building",
            startDateTime: "2025-12-30T09:00:00Z",
            location: "Mtatsminda Park",
            status: "Waitlisted",
            registeredAt: "2025-12-21T09:15:00Z",
            eventIsActive: true,
            eventMessage: "You are #3 on the waitlist"
        ),
        Registration(
            registrationId: 503,
            eventId: 103,
            eventTitle: "Annual Company Conference",
            eventType: "Conference",
            startDateTime: "2026-01-15T09:00:00Z",
            location: "Radisson Blu Iveria Hotel",
            status: "Confirmed",
            registeredAt: "2025-12-18T16:45:00Z",
            eventIsActive: true,
            eventMessage: nil
        )
    ]
    
    // MARK: - Mock Notifications
    // MARK: - Mock Notifications
    static let notifications: [Notification] = [
        // Registration confirmations
        Notification(
            id: 1,
            type: "Registration",
            title: "Registration Confirmed",
            message: "You're registered for Python for Beginners on Jan 2, 2026",
            eventId: 5,
            createdAt: "2025-12-24T10:30:00Z",
            isRead: false
        ),
        Notification(
            id: 2,
            type: "Registration",
            title: "Registration Confirmed",
            message: "You're registered for Security Awareness on Jan 4, 2026",
            eventId: 6,
            createdAt: "2025-12-23T14:20:00Z",
            isRead: false
        ),
        
        // Event reminders
        Notification(
            id: 3,
            type: "Reminder",
            title: "Event Tomorrow!",
            message: "Python for Beginners starts tomorrow at 10:00 AM. Don't forget your laptop!",
            eventId: 5,
            createdAt: "2025-12-25T09:00:00Z",
            isRead: false
        ),
        Notification(
            id: 4,
            type: "Reminder",
            title: "Event Starts in 3 Days",
            message: "Security Awareness training is coming up. Prepare your questions!",
            eventId: 6,
            createdAt: "2025-12-22T15:00:00Z",
            isRead: true
        ),
        Notification(
            id: 5,
            type: "Reminder",
            title: "Event This Week",
            message: "Summer BBQ is this Saturday! RSVP confirmed.",
            eventId: 7,
            createdAt: "2025-12-20T11:00:00Z",
            isRead: true
        ),
        
        // Waitlist updates
        Notification(
            id: 6,
            type: "Waitlist",
            title: "Moved Up on Waitlist",
            message: "You're now #2 on the waitlist for Python for Beginners",
            eventId: 5,
            createdAt: "2025-12-21T16:45:00Z",
            isRead: true
        ),
        Notification(
            id: 7,
            type: "Waitlist",
            title: "Waitlist Confirmation",
            message: "A spot opened up! You're confirmed for Security Awareness",
            eventId: 6,
            createdAt: "2025-12-19T13:20:00Z",
            isRead: true
        ),
        
        // Event updates
        Notification(
            id: 8,
            type: "Update",
            title: "Location Changed",
            message: "Python for Beginners has moved to Lab 3 (previously Lab 2)",
            eventId: 5,
            createdAt: "2025-12-18T10:00:00Z",
            isRead: true
        ),
        Notification(
            id: 9,
            type: "Update",
            title: "New Materials Available",
            message: "Pre-event materials for Security Awareness are now available",
            eventId: 6,
            createdAt: "2025-12-17T14:30:00Z",
            isRead: true
        ),
        Notification(
            id: 10,
            type: "Update",
            title: "Speaker Announcement",
            message: "Special guest speaker added to Summer BBQ event!",
            eventId: 7,
            createdAt: "2025-12-16T09:15:00Z",
            isRead: true
        ),
        
        // New events
        Notification(
            id: 11,
            type: "Event",
            title: "New Event Available",
            message: "Summer BBQ registration is now open! Limited spots available.",
            eventId: 7,
            createdAt: "2025-12-15T08:00:00Z",
            isRead: true
        ),
        Notification(
            id: 12,
            type: "Event",
            title: "New Workshop Added",
            message: "Check out the new Python for Beginners workshop!",
            eventId: 5,
            createdAt: "2025-12-14T12:00:00Z",
            isRead: true
        ),
        
        // Cancellations
        Notification(
            id: 13,
            type: "Update",
            title: "Event Cancelled",
            message: "iOS Advanced workshop scheduled for Dec 28 has been cancelled",
            eventId: nil,
            createdAt: "2025-12-13T10:30:00Z",
            isRead: true
        ),
        
        // General announcements
        Notification(
            id: 14,
            type: "Update",
            title: "Survey Request",
            message: "Help us improve! Share feedback on your recent event experience",
            eventId: nil,
            createdAt: "2025-12-12T16:00:00Z",
            isRead: true
        ),
        Notification(
            id: 15,
            type: "Update",
            title: "Policy Update",
            message: "New cancellation policy: Cancel up to 24 hours before events",
            eventId: nil,
            createdAt: "2025-12-11T11:00:00Z",
            isRead: true
        )
    ]

    // MARK: - Generate Mock Agenda
    static func generateAgenda(for eventId: Int) -> [AgendaItem]? {
        // Generate random agenda based on event ID
        let agendaTemplates: [[AgendaItem]] = [
            // Template 1: Workshop style
            [
                AgendaItem(id: "1", time: "10:00 AM", title: "Welcome & Introduction", description: "Event overview and objectives", duration: "30 min"),
                AgendaItem(id: "2", time: "10:30 AM", title: "Main Session", description: "Deep dive into the topic", duration: "90 min"),
                AgendaItem(id: "3", time: "12:00 PM", title: "Lunch Break", description: "Networking lunch", duration: "60 min"),
                AgendaItem(id: "4", time: "1:00 PM", title: "Hands-on Practice", description: "Interactive exercises", duration: "90 min"),
                AgendaItem(id: "5", time: "2:30 PM", title: "Q&A and Wrap-up", description: "Questions and closing remarks", duration: "30 min")
            ],
            // Template 2: Conference style
            [
                AgendaItem(id: "1", time: "9:00 AM", title: "Registration & Coffee", description: "Check-in and networking", duration: "60 min"),
                AgendaItem(id: "2", time: "10:00 AM", title: "Opening Keynote", description: "Vision and strategy", duration: "60 min"),
                AgendaItem(id: "3", time: "11:00 AM", title: "Panel Discussion", description: "Expert insights", duration: "90 min"),
                AgendaItem(id: "4", time: "12:30 PM", title: "Lunch", description: "Networking lunch", duration: "90 min"),
                AgendaItem(id: "5", time: "2:00 PM", title: "Breakout Sessions", description: "Choose your track", duration: "90 min"),
                AgendaItem(id: "6", time: "3:30 PM", title: "Closing Remarks", description: "Summary and next steps", duration: "30 min")
            ],
            // Template 3: Training style
            [
                AgendaItem(id: "1", time: "9:30 AM", title: "Introduction", description: "Course overview", duration: "30 min"),
                AgendaItem(id: "2", time: "10:00 AM", title: "Module 1", description: "Fundamentals", duration: "90 min"),
                AgendaItem(id: "3", time: "11:30 AM", title: "Module 2", description: "Advanced concepts", duration: "90 min"),
                AgendaItem(id: "4", time: "1:00 PM", title: "Practical Lab", description: "Apply what you learned", duration: "2 hours")
            ],
            // Template 4: Social event style
            [
                AgendaItem(id: "1", time: "6:00 PM", title: "Welcome Reception", description: "Drinks and appetizers", duration: "60 min"),
                AgendaItem(id: "2", time: "7:00 PM", title: "Dinner", description: "Main course", duration: "90 min"),
                AgendaItem(id: "3", time: "8:30 PM", title: "Entertainment", description: "Live music and activities", duration: "2 hours")
            ]
        ]
        
        // Use event ID to consistently pick the same template for the same event
        let templateIndex = eventId % agendaTemplates.count
        return agendaTemplates[templateIndex]
    }

    // MARK: - Generate Mock Speakers
    static func generateSpeakers(for eventId: Int) -> [Speaker]? {
        // Pool of speakers
        let allSpeakers = [
            Speaker(id: "1", name: "Sarah Johnson", title: "Senior Developer", bio: "15+ years of industry experience", imageUrl: "https://i.pravatar.cc/300?img=45", company: "TBC Tech"),
            Speaker(id: "2", name: "Michael Chen", title: "Data Science Lead", bio: "Expert in AI and machine learning", imageUrl: "https://i.pravatar.cc/300?img=12", company: "TBC AI Labs"),
            Speaker(id: "3", name: "Alex Martinez", title: "Chief Security Officer", bio: "Cybersecurity expert", imageUrl: "https://i.pravatar.cc/300?img=33", company: "TBC Security"),
            Speaker(id: "4", name: "Emily Davis", title: "Product Manager", bio: "10+ years building products", imageUrl: "https://i.pravatar.cc/300?img=47", company: "TBC"),
            Speaker(id: "5", name: "David Kim", title: "Engineering Manager", bio: "Leading high-performing teams", imageUrl: "https://i.pravatar.cc/300?img=52", company: "TBC Engineering"),
            Speaker(id: "6", name: "Lisa Anderson", title: "UX Designer", bio: "Award-winning designer", imageUrl: "https://i.pravatar.cc/300?img=38", company: "TBC Design"),
            Speaker(id: "7", name: "James Wilson", title: "DevOps Lead", bio: "Infrastructure and automation expert", imageUrl: "https://i.pravatar.cc/300?img=15", company: "TBC Cloud"),
            Speaker(id: "8", name: "Maria Garcia", title: "Business Analyst", bio: "Data-driven decision making", imageUrl: "https://i.pravatar.cc/300?img=29", company: "TBC Analytics")
        ]
        
        // Use event ID to consistently pick 1-3 speakers for the same event
        let speakerCount = (eventId % 3) + 1 // 1, 2, or 3 speakers
        let startIndex = eventId % allSpeakers.count
        
        var selectedSpeakers: [Speaker] = []
        for i in 0..<speakerCount {
            let index = (startIndex + i) % allSpeakers.count
            selectedSpeakers.append(allSpeakers[index])
        }
        
        return selectedSpeakers.isEmpty ? nil : selectedSpeakers
    }
}

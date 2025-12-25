//
//  MockData.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import Foundation

struct MockData {
    
    // MARK: - Mock Events
    static let events: [Event] = [
        Event(
            id: 101,
            title: "iOS Development Workshop",
            description: "Learn advanced iOS development techniques with SwiftUI and Combine framework. Perfect for intermediate developers looking to level up their skills.",
            eventTypeName: "Workshop",
            startDateTime: "2025-12-28T10:00:00Z",
            endDateTime: "2025-12-28T16:00:00Z",
            location: "TBC Academy, Tbilisi",
            capacity: 30,
            confirmedCount: 22,
            waitlistedCount: 5,
            imageUrl: "https://picsum.photos/seed/ios-workshop/800/400",
            organizerName: "Tech Learning Team",
            tags: ["iOS", "SwiftUI", "Development"],
            isActive: true,
            agenda: mockAgenda,
            speakers: mockSpeakers
        ),
        Event(
            id: 102,
            title: "Team Building Adventure",
            description: "Outdoor team building activities including hiking, problem-solving challenges, and team bonding exercises.",
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
            isActive: true,
            agenda: mockTeamBuildingAgenda,
            speakers: nil
        ),
        Event(
            id: 103,
            title: "Annual Company Conference",
            description: "Join us for our annual conference featuring keynote speakers, product launches, and networking opportunities.",
            eventTypeName: "Conference",
            startDateTime: "2026-01-15T09:00:00Z",
            endDateTime: "2026-01-15T17:00:00Z",
            location: "Radisson Blu Iveria Hotel",
            capacity: 200,
            confirmedCount: 145,
            waitlistedCount: 12,
            imageUrl: "https://picsum.photos/seed/conference/800/400",
            organizerName: "Executive Team",
            tags: ["Conference", "Networking", "Business"],
            isActive: true,
            agenda: mockConferenceAgenda,
            speakers: mockConferenceSpeakers
        ),
        Event(
            id: 104,
            title: "Machine Learning Training",
            description: "Comprehensive training on machine learning fundamentals, algorithms, and practical applications.",
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
            isActive: true,
            agenda: mockTrainingAgenda,
            speakers: mockMLSpeakers
        ),
        Event(
            id: 105,
            title: "New Year Celebration",
            description: "Celebrate the new year with colleagues! Dinner, music, and entertainment.",
            eventTypeName: "Social",
            startDateTime: "2025-12-31T19:00:00Z",
            endDateTime: "2026-01-01T01:00:00Z",
            location: "Fabrika Tbilisi",
            capacity: 100,
            confirmedCount: 87,
            waitlistedCount: 0,
            imageUrl: "https://picsum.photos/seed/new-year/800/400",
            organizerName: "Social Committee",
            tags: ["Party", "Celebration", "Social"],
            isActive: true,
            agenda: nil,
            speakers: nil
        )
    ]
    
    // MARK: - Mock Agenda Items
    static let mockAgenda: [AgendaItem] = [
        AgendaItem(
            id: "1",
            time: "10:00 AM",
            title: "Welcome & Introduction",
            description: "Overview of the workshop and introduction to SwiftUI fundamentals",
            duration: "30 min"
        ),
        AgendaItem(
            id: "2",
            time: "10:30 AM",
            title: "SwiftUI Deep Dive",
            description: "Advanced SwiftUI patterns, state management, and custom views",
            duration: "90 min"
        ),
        AgendaItem(
            id: "3",
            time: "12:00 PM",
            title: "Lunch Break",
            description: "Networking lunch with fellow developers",
            duration: "60 min"
        ),
        AgendaItem(
            id: "4",
            time: "1:00 PM",
            title: "Combine Framework",
            description: "Reactive programming with Combine and practical examples",
            duration: "90 min"
        ),
        AgendaItem(
            id: "5",
            time: "2:30 PM",
            title: "Hands-on Project",
            description: "Build a complete SwiftUI app with Combine integration",
            duration: "90 min"
        ),
        AgendaItem(
            id: "6",
            time: "4:00 PM",
            title: "Q&A and Wrap-up",
            description: "Questions, discussion, and closing remarks",
            duration: "30 min"
        )
    ]
    
    static let mockTeamBuildingAgenda: [AgendaItem] = [
        AgendaItem(
            id: "1",
            time: "9:00 AM",
            title: "Morning Gathering",
            description: "Check-in and team assignments",
            duration: "30 min"
        ),
        AgendaItem(
            id: "2",
            time: "9:30 AM",
            title: "Hiking Adventure",
            description: "Guided hike through scenic trails",
            duration: "2 hours"
        ),
        AgendaItem(
            id: "3",
            time: "11:30 AM",
            title: "Team Challenges",
            description: "Problem-solving activities and team games",
            duration: "2 hours"
        ),
        AgendaItem(
            id: "4",
            time: "1:30 PM",
            title: "Lunch",
            description: "Picnic lunch at the summit",
            duration: "90 min"
        ),
        AgendaItem(
            id: "5",
            time: "3:00 PM",
            title: "Reflection Session",
            description: "Team discussion and bonding activities",
            duration: "60 min"
        )
    ]
    
    static let mockConferenceAgenda: [AgendaItem] = [
        AgendaItem(
            id: "1",
            time: "9:00 AM",
            title: "Registration & Coffee",
            description: "Check-in and morning refreshments",
            duration: "60 min"
        ),
        AgendaItem(
            id: "2",
            time: "10:00 AM",
            title: "Opening Keynote",
            description: "Company vision and strategic direction for 2026",
            duration: "60 min"
        ),
        AgendaItem(
            id: "3",
            time: "11:00 AM",
            title: "Product Showcase",
            description: "Launch of new products and features",
            duration: "90 min"
        ),
        AgendaItem(
            id: "4",
            time: "12:30 PM",
            title: "Networking Lunch",
            description: "Buffet lunch and networking opportunities",
            duration: "90 min"
        ),
        AgendaItem(
            id: "5",
            time: "2:00 PM",
            title: "Breakout Sessions",
            description: "Choose from 3 specialized tracks",
            duration: "90 min"
        ),
        AgendaItem(
            id: "6",
            time: "3:30 PM",
            title: "Panel Discussion",
            description: "Industry leaders discuss future trends",
            duration: "60 min"
        ),
        AgendaItem(
            id: "7",
            time: "4:30 PM",
            title: "Closing Remarks",
            description: "Summary and next steps",
            duration: "30 min"
        )
    ]
    
    static let mockTrainingAgenda: [AgendaItem] = [
        AgendaItem(
            id: "1",
            time: "10:00 AM",
            title: "ML Fundamentals",
            description: "Introduction to machine learning concepts",
            duration: "90 min"
        ),
        AgendaItem(
            id: "2",
            time: "11:30 AM",
            title: "Algorithms Overview",
            description: "Common ML algorithms and use cases",
            duration: "90 min"
        ),
        AgendaItem(
            id: "3",
            time: "1:00 PM",
            title: "Hands-on Lab",
            description: "Build and train your first ML model",
            duration: "2 hours"
        )
    ]
    
    // MARK: - Mock Speakers
    static let mockSpeakers: [Speaker] = [
        Speaker(
            id: "1",
            name: "Alex Thompson",
            title: "Senior iOS Engineer",
            bio: "10+ years of iOS development experience. Contributed to major apps used by millions worldwide.",
            imageUrl: "https://i.pravatar.cc/300?img=33",
            company: "TBC"
        ),
        Speaker(
            id: "2",
            name: "Sarah Martinez",
            title: "SwiftUI Expert",
            bio: "Author of 'Mastering SwiftUI' and speaker at Apple WWDC. Passionate about clean code and architecture.",
            imageUrl: "https://i.pravatar.cc/300?img=47",
            company: "Apple"
        )
    ]
    
    static let mockConferenceSpeakers: [Speaker] = [
        Speaker(
            id: "3",
            name: "David Chen",
            title: "CEO",
            bio: "Visionary leader with 15 years in fintech. Leading TBC's digital transformation.",
            imageUrl: "https://i.pravatar.cc/300?img=12",
            company: "TBC"
        ),
        Speaker(
            id: "4",
            name: "Emma Wilson",
            title: "Chief Product Officer",
            bio: "Product strategy expert. Previously led product teams at major tech companies.",
            imageUrl: "https://i.pravatar.cc/300?img=20",
            company: "TBC"
        ),
        Speaker(
            id: "5",
            name: "Michael Brown",
            title: "CTO",
            bio: "Technology innovator driving engineering excellence and technical strategy.",
            imageUrl: "https://i.pravatar.cc/300?img=52",
            company: "TBC"
        )
    ]
    
    static let mockMLSpeakers: [Speaker] = [
        Speaker(
            id: "6",
            name: "Dr. Lisa Anderson",
            title: "Head of Data Science",
            bio: "PhD in Machine Learning. Published researcher with 50+ papers in top AI conferences.",
            imageUrl: "https://i.pravatar.cc/300?img=38",
            company: "TBC AI Labs"
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
    static let notifications: [Notification] = [
        Notification(
            id: 1,
            type: "registration_confirmed",
            title: "Registration Confirmed",
            message: "You're registered for iOS Development Workshop on Dec 28, 2025",
            eventId: 101,
            eventTitle: "iOS Development Workshop",
            createdAt: "2025-12-20T14:30:00Z",
            isRead: false,
            imageUrl: "https://picsum.photos/seed/notif-1/100/100"
        ),
        Notification(
            id: 2,
            type: "event_reminder",
            title: "Event Reminder",
            message: "iOS Development Workshop starts in 3 days! Don't forget to bring your laptop.",
            eventId: 101,
            eventTitle: "iOS Development Workshop",
            createdAt: "2025-12-25T09:00:00Z",
            isRead: false,
            imageUrl: "https://picsum.photos/seed/notif-2/100/100"
        ),
        Notification(
            id: 3,
            type: "waitlist_update",
            title: "Waitlist Update",
            message: "You've moved up to position #3 on the waitlist for Team Building Adventure",
            eventId: 102,
            eventTitle: "Team Building Adventure",
            createdAt: "2025-12-24T15:20:00Z",
            isRead: true,
            imageUrl: "https://picsum.photos/seed/notif-3/100/100"
        ),
        Notification(
            id: 4,
            type: "event_update",
            title: "Event Update",
            message: "Annual Company Conference location has been updated to Radisson Blu Iveria Hotel",
            eventId: 103,
            eventTitle: "Annual Company Conference",
            createdAt: "2025-12-23T11:00:00Z",
            isRead: true,
            imageUrl: "https://picsum.photos/seed/notif-4/100/100"
        ),
        Notification(
            id: 5,
            type: "new_event",
            title: "New Event Available",
            message: "New Year Celebration event is now open for registration!",
            eventId: 105,
            eventTitle: "New Year Celebration",
            createdAt: "2025-12-22T10:00:00Z",
            isRead: true,
            imageUrl: "https://picsum.photos/seed/notif-5/100/100"
        ),
        Notification(
            id: 6,
            type: "event_cancelled",
            title: "Event Cancelled",
            message: "Unfortunately, the Python Workshop scheduled for Jan 5 has been cancelled.",
            eventId: nil,
            eventTitle: nil,
            createdAt: "2025-12-20T08:30:00Z",
            isRead: true,
            imageUrl: "https://picsum.photos/seed/notif-6/100/100"
        )
    ]
}
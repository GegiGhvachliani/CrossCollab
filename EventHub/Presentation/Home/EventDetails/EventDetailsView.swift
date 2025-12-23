//
//  DetailsView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI

struct EventDetailsModel {
    let title: String
    let date: String
    let time: String
    let tags: [String]
    let location: String
    let registrationInfo: String
    let registrationDeadline: String
    let description: String
    let agenda: [AgendaItem]
    let speakers: [Speaker]
    let faq: [Faq]
}

struct AgendaItem: Identifiable {
    let id = UUID()
    let order: Int
    let title: String
    let description: String
}

struct Speaker: Identifiable {
    let id = UUID()
    let name: String
    let role: String
}

struct Faq: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
}

struct EventDetailsView: View {

    @StateObject private var viewModel: EventsDetailsViewModel

    init(eventId: Int) {
        _viewModel = StateObject(
            wrappedValue: EventsDetailsViewModel(eventID: eventId)
        )
    }

    var body: some View {
        if let event = viewModel.event {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    EventBanner(imageURL: URL(string: "https://picsum.photos/400/300?grayscale"))

                    EventTags(tags: event.tags)

                    EventInfoSection(event: event)
                    Divider()
                    RegisterSection(registrationDeadline: event.registrationDeadline) {
                           print("რეგისტრაციის ღილაკი")
                    }
                    Divider()
                    AboutEventSection(description: event.description)
                    Divider()
                    AgendaSection(items: event.agenda)
                    Divider()
                    SpeakersSection(speakers: event.speakers)
                    Divider()
                    FaqSection(items: event.faq
                    )
                }
            }
            .navigationTitle("Event Details")
        } else {
            ProgressView("Loading...")
        }
    }
}


import SwiftUI

struct AboutEventSection: View {

    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About this event")
                .font(.system(size: 18))

            Text(description)
                .font(.system(size: 14))
                .foregroundColor(.gray300)
        }
        .padding(.horizontal)
    }
}


import SwiftUI

struct AgendaSection: View {

    let items: [AgendaItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            Text("Agenda")
                .font(.system(size: 18))
                .foregroundStyle(.gray900)

            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                let isLast = index == items.indices.last

                HStack(alignment: .top, spacing: 12) {

                    VStack {
                        ZStack {
                            Circle()
                                .fill(.gray300.opacity(0.2))
                                .frame(width: 28, height: 28)

                            Text("\(item.order)")
                                .font(.system(size: 12))
                        }

                        if !isLast {
                            Rectangle()
                                .fill(.gray300.opacity(0.2))
                                .frame(width: 1)
                                .frame(maxHeight: .infinity)
                        }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.system(size: 14))
                            .foregroundColor(.gray900)

                        Text(item.description)
                            .font(.system(size: 14))
                            .foregroundColor(.gray300)
                    }
                }
                .frame(minHeight: isLast ? 10 : 70)
            }
        }
        .padding(.horizontal)
    }
}


import SwiftUI

struct EventBanner: View {
    //MARK: - Properties
    let imageURL: URL?

    //MARK: - Body
    var body: some View {
        ZStack {
            if let imageURL {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
        }
        .frame(height: 192)
        .clipped()
    }
}

import SwiftUI

struct EventDetailRow: View {
    
    //MARK: - properties
    let icon: String
    let text: String
    
    //MARK: - Body
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.system(size: 12))
        .foregroundStyle(.gray300)
    }
    
    
    import SwiftUI
    
    struct EventInfoSection: View {
        
        let event: EventDetailsModel
        
        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                
                Text(event.title)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(.gray900)
                
                EventDetailRow(icon: "calendar", text: event.date)
                EventDetailRow(icon: "clock", text: event.time)
                EventDetailRow(icon: "mappin.and.ellipse", text: event.location)
                EventDetailRow(icon: "person.2", text: event.registrationInfo)
            }
            .padding(.horizontal)
        }
    }
    
    
    import SwiftUI
    
    struct EventTags: View {
        //MARK: - Properties
        let tags: [String]
        
        //MARK: - Body
        var body: some View {
            HStack(spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .font(.system(size: 12))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(.gray100)
                        .foregroundColor(.gray900)
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal)
        }
    }
    
    
    import SwiftUI
    
    struct FaqSection: View {
        
        let items: [Faq]
        
        var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                
                Text("Frequently Asked Questions")
                    .font(.system(size: 18))
                    .foregroundStyle(.gray900)
                
                ForEach(items) { item in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.question)
                            .font(.system(size: 14))
                            .foregroundColor(.gray900)
                        
                        Text(item.answer)
                            .font(.system(size: 14))
                            .foregroundColor(.gray300)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
    
    import SwiftUI

    struct RegisterSection: View {

        let registrationDeadline: String
        let onRegister: () -> Void

        var body: some View {
            VStack(alignment: .leading, spacing: 12) {
                Button(action: onRegister) {
                    Text("Register Now")
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.black)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 8)

                Text(registrationDeadline)
                    .font(.system(size: 12))
                    .foregroundColor(.gray300)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal)
        }
    }


    import SwiftUI

    struct SpeakersSection: View {

        let speakers: [Speaker]

        var body: some View {
            VStack(alignment: .leading, spacing: 16) {

                Text("Featured Speakers")
                    .font(.system(size: 18))

                ForEach(speakers) { speaker in
                    HStack(spacing: 12) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 56, height: 56)
                            .foregroundColor(.gray300)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(speaker.name)
                                .font(.system(size: 16))
                                .foregroundStyle(.gray900)

                            Text(speaker.role)
                                .font(.system(size: 14))
                                .foregroundStyle(.gray300)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }

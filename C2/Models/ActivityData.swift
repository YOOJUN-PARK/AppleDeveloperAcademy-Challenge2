//
//  ActivityData.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftData
import Foundation

enum TimeSlot: String, CaseIterable, Codable {
    case all = "전체"
    case morning = "☀️ 오전"
    case evening = "🌔 오후"
    
    static var selectableCases: [TimeSlot] { [.morning, .evening] }
}

// Filter를 위한 Tags 열거형
enum Tag: String, CaseIterable, Codable {
    case pingpong = "탁구"
    case tennis = "테니스"
    case badminton = "배드민턴"
    case running = "러닝"
    case hiking = "등산"
    case surfing = "서핑"
    case swimming = "수영"
    case bicycle = "자전거"
    case gym = "헬스"
    
    var iconName: String {
        switch self {
        case .pingpong: return "figure.table.tennis"
        case .tennis: return "figure.tennis"
        case .badminton: return "figure.badminton"
        case .running: return "figure.run"
        case .hiking: return "figure.hiking"
        case .surfing: return "figure.surfing"
        case .swimming: return "figure.open.water.swim"
        case .bicycle: return "figure.outdoor.cycle"
        case .gym: return "figure.strengthtraining.traditional"
        }
    }
}

// Schema
@Model
class ActivityData: Identifiable {
    @Attribute(.unique) var id = UUID()
    
    var authorName: String
    var authorImage: Data?
    
    var timeSlot: TimeSlot
    var tag: Tag
    
    var imageTitle: String
    var imageDescription: String
    var imageData: [Data]
    
    init(authorName: String, authorImage: Data? = nil, timeSlot: TimeSlot, tag: Tag, imageTitle: String, imageDescription: String, imageData: [Data]) {
        self.authorName = authorName
        self.authorImage = authorImage
        self.timeSlot = timeSlot
        self.tag = tag
        self.imageTitle = imageTitle
        self.imageDescription = imageDescription
        self.imageData = imageData
    }
}
@Model
class UserData: Identifiable {
    @Attribute(.unique) var id = UUID()
    
    var userName: String
    var userImage: Data?
    
    init(userName: String, userImage: Data? = nil) {
        self.userName = userName
        self.userImage = userImage
    }
}

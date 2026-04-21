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
    case tennis = "테니스"
    case running = "러닝"
    case tabletennis = "탁구"
    case surfing = "서핑"
    case swimming = "수영"
    
    var iconName: String {
        switch self {
        case .tennis: return "figure.tennis"
        case .running: return "figure.run"
        case .tabletennis: return "figure.table.tennis"
        case .surfing: return "figure.surfing"
        case .swimming: return "figure.open.water.swim"
        }
    }
}

// 자료구조 Schema
@Model
class ActivityData: Identifiable {
    @Attribute(.unique) var id = UUID()
    
    var timeSlot: TimeSlot
    var tag: Tag
    
    var imageTitle: String
    var imageDescription: String
    var imageData: [Data]
    
    init(timeSlot: TimeSlot, tag: Tag, imageTitle: String, imageDescription: String, imageData: [Data] = []) {
        self.timeSlot = timeSlot
        self.tag = tag
        self.imageTitle = imageTitle
        self.imageDescription = imageDescription
        self.imageData = imageData
    }
}

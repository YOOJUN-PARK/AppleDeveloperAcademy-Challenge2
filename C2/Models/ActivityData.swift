//
//  ActivityData.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftData
import Foundation

// Filter를 위한 Tags 열거형
enum Tag: String, CaseIterable, Codable {
    case morning = "오전"
    case evening = "오후"
    case tennis = "테니스"
    case running = "러닝"
    case tabletennis = "탁구"
    case surfing = "서핑"
    case swimming = "수영"
    
    var iconName: String {
        switch self {
        case .morning: return "sun.max"
        case .evening: return "moon"
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
    
    var tags: [Tag]
    
    var imageTitle: String
    var imageDescription: String
    var imageData: [Data]
    
    init(tags: [Tag], imageTitle: String, imageDescription: String, imageData: [Data] = []) {
        self.tags = tags
        self.imageTitle = imageTitle
        self.imageDescription = imageDescription
        self.imageData = imageData
    }
}

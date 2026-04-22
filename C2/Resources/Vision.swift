//
//  Vision.swift
//  C2
//
//  Created by YOOJUN PARK on 4/16/26.
//

import Vision

func imageClassification(imageData: Data) async -> (timeSlot: TimeSlot?, tag: Tag?) {
    
    let tagMap: [String: Tag] = [
        "pingpong": .pingpong,
        "tennis": .tennis,
        "badminton": .badminton,
        "running": .running,
        "hiking": .hiking,
        "surfing": .surfing,
        "swimming": .swimming,
        "bicycle": .bicycle,
        "gym": .gym
    ]
    
    let timeSlotMap: [String: TimeSlot] = [
        "blue_sky": .morning,
        "night_sky": .evening
    ]
    
    do {
        let request = ClassifyImageRequest()
        let observations = try await request.perform(on: imageData)
        
        var topTag: Tag? = nil
        var topTimeSlot: TimeSlot? = nil
        
        for observation in observations { // observations은 confidence 내림차순 정렬.
            let id = observation.identifier.lowercased()
            if topTag == nil { topTag = tagMap.first { id.contains($0.key) }?.value }
            if topTimeSlot == nil { topTimeSlot = timeSlotMap.first { id.contains($0.key) }?.value }
            if topTag != nil && topTimeSlot != nil { break }
        }
        
        return (topTimeSlot, topTag)
        
    } catch {
        return (nil, nil)
    }
}

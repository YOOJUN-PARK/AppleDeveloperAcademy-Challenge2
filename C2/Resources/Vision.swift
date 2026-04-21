//
//  Vision.swift
//  C2
//
//  Created by YOOJUN PARK on 4/16/26.
//

import Vision

func imageClassification(imageData: Data) async -> (timeSlot: String?, tag: String?) {
    
    // 선택 가능한 종목
    let tagList = [
        "pingpong", "tennis", "badminton",
        "running", "hiking",
        "surfing", "swimming",
        "bicycle",
        "gym"
    ]
    
    // 오전, 오후를 구별하기 위한 identifier
    let timeSlotList = ["blue_sky", "night_sky"]
    
    do {
        let request = ClassifyImageRequest()
        let observations = try await request.perform(on: imageData)
        
        let topTag = observations.first { observation in
            tagList.contains { observation.identifier.lowercased().contains($0) }
        }?.identifier.lowercased()
        
        let topTimeSlot = observations.first { observation in
            timeSlotList.contains { observation.identifier.lowercased().contains($0) }
        }?.identifier.lowercased()
        
        return (topTimeSlot, topTag)
        
    } catch {
        return (nil, nil)
    }
}

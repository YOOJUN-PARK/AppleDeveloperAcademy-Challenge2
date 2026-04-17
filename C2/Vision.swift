//
//  Vision.swift
//  C2
//
//  Created by YOOJUN PARK on 4/16/26.
//

import Vision

func imageClassification(imageData: Data) async -> [String] {
    let whitelist = [
        "tabletennis", "pingpong", "tennis", "pickleball", "racket", "badminton",
        
        "running", "jogging", "marathon", "walking", "hiking", "climbing", "trail",
        
        "skydiving", "surfing", "swimming", "diving", "snorkeling", "kayak", "sailing",
        
        "soccer", "basketball", "golf", "cycling", "bicycle",
        
        "gym", "fitness", "workout", "weightlifting",
        
        "sunrise", "sunset"
    ]
    
    
    do {
        let request = ClassifyImageRequest()
        let observations = try await request.perform(on: imageData)
        
        let filteredResults = observations
            .filter { observation in
                whitelist.contains { keyword in
                    observation.identifier.lowercased().contains(keyword)
                }
            }
            .map { return mappingToKorean(eng: $0.identifier.lowercased()) }
        return Array(filteredResults.prefix(1))
        
    } catch {
        return []
    }
}

func mappingToKorean(eng: String) -> String {
    
    if containsAny(eng, ["tabletennis", "pingpong"]) { return "탁구" }
    if containsAny(eng, ["tennis", "racket", "pickleball"]) { return "테니스" }
    if containsAny(eng, ["badminton"]) { return "배드민턴" }
    
    if containsAny(eng, ["running", "jogging", "marathon", "walking"]) { return "러닝" }
    if containsAny(eng, ["hiking", "climbing", "trail"]) { return "등산" }
    
    if containsAny(eng, ["skydiving"]) { return "스카이다이빙" }
    if containsAny(eng, ["surfing"]) { return "서핑" }
    if containsAny(eng, ["swimming", "diving"]) { return "수영" }
    if containsAny(eng, ["snorkeling"]) { return "스노클링" }
    if containsAny(eng, ["kayak", "sailing"]) { return "카약" }
    
    if containsAny(eng, ["soccer"]) { return "축구" }
    if containsAny(eng, ["basketball"]) { return "농구" }
    //if containsAny(eng, ["baseball"]) { return "야구" }
    if containsAny(eng, ["golf"]) { return "골프" }
    if containsAny(eng, ["cycling", "bicycle"]) { return "자전거" }
    
    if containsAny(eng, ["gym", "fitness", "workout", "weightlifting"]) { return "헬스" }
    
    if containsAny(eng, ["sunrise"]) { return "오전" }
    if containsAny(eng, ["sunset"]) { return "오후" }
    
    return eng
}

func containsAny(_ text: String, _ keywords: [String]) -> Bool {
    return keywords.contains { text.contains($0) }
}

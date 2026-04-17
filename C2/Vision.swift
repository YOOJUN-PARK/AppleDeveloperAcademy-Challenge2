//
//  Vision.swift
//  C2
//
//  Created by YOOJUN PARK on 4/16/26.
//

import Vision

func imageClassification(imageData: Data) async -> [String] {
    let whitelist = [
        "tennis", "pickleball", "racket", "badminton", "table tennis", "ping pong",
        
        "running", "jogging", "marathon", "walking", "hiking", "climbing", "trail",
        
        "surfing", "swimming", "diving", "snorkeling", "kayak", "sailing",
        
        "soccer", "basketball", "baseball", "golf", "cycling", "bicycle",
        
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
            .map { $0.identifier }
        return Array(filteredResults.prefix(5))
        
    } catch {
        return []
    }
}

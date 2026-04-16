//
//  Vision.swift
//  C2
//
//  Created by YOOJUN PARK on 4/16/26.
//

import Vision

func imageClassification(imageData: Data) async -> [String] {
    
    do {
        let request = ClassifyImageRequest()
        let observations = try await request.perform(on: imageData)
        
        return Array(observations.map(\.identifier).prefix(5)) // 5개의 결과 반환
        
    } catch {
        return []
    }
}

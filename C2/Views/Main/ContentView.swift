//
//  ContentView.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State var imageData: [Data] = [] // 연산에 이용할 이미지
    @State var detectedTags: (timeSlot: String?, tag: String?) = (nil, nil) // Vision 결과
    
    var body: some View {
        VStack {
            PhotoPicker(imageData: $imageData)
            
            VStack {
                // 이미지 출력
                TabView {
                    ForEach(0..<imageData.count, id: \.self) { index in
                        if let uiImage = UIImage(data: imageData[index]) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 13))
                                .padding(.horizontal)
                        }
                    }
                }
                .frame(height: 250)
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                
                // Vision 결과 출력
                if let timeSlot = detectedTags.timeSlot {
                    Text("\(timeSlot)")
                        .padding(5)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(5)
                }
                if let tag = detectedTags.tag {
                    Text("\(tag)")
                        .padding(5)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(5)
                }
                
            }
        }
        // Vision 실행
        .task(id: imageData) {
            guard let image = imageData.first else { return } // imageData Array에는 1개 원소만 존재
            self.detectedTags = await imageClassification(imageData: image)
        }
    }
    
}

#Preview {
    ContentView()
}


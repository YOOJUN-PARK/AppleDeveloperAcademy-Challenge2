//
//  AddDataView.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI
import SwiftData

struct AddData: View {
    @State var activityData: ActivityData? = nil // 기존 activityData 수정 시
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // activityData Model의 파라미터
    @State var tags: [Tag] = []
    @State var imageTitle: String = ""
    @State var imageDescription: String = ""
    @State var imageData: [Data] = []
    
    var body: some View {
        // 상단 View
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                ScrollView {
                    // PhotoPicker, Text Field 묶음
                    VStack {
                        
                        // PhotoPicker
                        VStack {
                            if !imageData.isEmpty {
                                // 사진 미리보기
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
                                
                                Button(role: .destructive, action: {
                                    withAnimation { imageData = [] }
                                }) {
                                    Label("사진 모두 지우기", systemImage: "trash")
                                        .font(.headline)
                                        .padding(.vertical, 7)
                                }
                            } else {
                                PhotoPicker(imageData: $imageData)
                                Text("여러 Activity 사진을 선택하세요.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .padding(.top, 2)
                            }
                        }
                        .padding(.top, 20)
                        
                        // Text Editer
                        VStack(alignment: .leading, spacing: 5) {
                            
                            // Title Field
                            VStack(alignment: .leading) {
                                Text("제목")
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(.leading, 7)
                                    .padding(.top, 20)
                                TextField("", text: $imageTitle, prompt: Text("어떤 활동을 하셨나요?").foregroundColor(.white.opacity(0.7)))
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(13)
                            } // Title Field
                            .padding(.bottom, 20)
                            
                            // // Description Field
                            VStack(alignment: .leading) {
                                Text("본문")
                                    .font(.headline)
                                    .foregroundColor(.white.opacity(0.9))
                                    .padding(.leading, 7)
                                ZStack(alignment: .topLeading) {
                                    if imageDescription.isEmpty {
                                        Text("자세한 내용을 기록해보세요.")
                                            .foregroundColor(.gray.opacity(0.6))
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 12)
                                    }
                                    TextEditor(text: $imageDescription)
                                        .frame(minHeight: 130)
                                        .scrollContentBackground(.hidden)
                                        .foregroundColor(.white)
                                        .background(Color.white.opacity(0.1))
                                        .cornerRadius(13)
                                }
                            } // Description Field
                        } // VStack - Text Editer
                        .padding(.horizontal)
                        .padding(.bottom, 1)
                        
                        // Tag Selection
                        VStack(alignment: .leading) {
                            Text("태그")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.leading, 7)
                                .padding(.top, 20)
                            
                            VStack(spacing: 0) { // Tag List
                                ForEach(Tag.allCases, id: \.self) { tag in
                                    
                                    Button(action: {
                                        if tags.contains(tag) { tags.removeAll { $0 == tag } }
                                        else { tags.append(tag) }
                                    } ) {
                                        // Button 한 칸
                                        HStack {
                                            Label(tag.rawValue, systemImage: tag.iconName)
                                                .foregroundStyle(.white)
                                            
                                            Spacer()
                                            
                                            if tags.contains(tag) {
                                                Image(systemName: "checkmark")
                                                    .foregroundStyle(.blue)
                                                    .fontWeight(.bold)
                                            }
                                        }
                                        .padding()
                                        .background(Color.white.opacity(0.05))
                                    } // Button
                                    
                                    Divider().background(Color.gray.opacity(0.3))
                                }
                            } // Tag List
                            .cornerRadius(13)
                        } // VStack - Tag Selection
                        .padding(.horizontal)
                        
                    } // VStack - Photo, Text, Tag
                } // ScrollView
            } // ZStack
            .navigationTitle(activityData == nil ? "Activity 추가하기" : "Activity 수정하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("취소") { dismiss() }
                        .fontWeight(.bold)
                        .foregroundStyle(.red.opacity(0.7))
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("저장") {
                        if let activityData = activityData { // 기존 activityData를 수정할 때,
                            activityData.tags = tags
                            activityData.imageTitle = imageTitle
                            activityData.imageDescription = imageDescription
                            activityData.imageData = imageData
                            
                            try? modelContext.save()
                            dismiss()
                        } else { // 새 activityData를 추가할 때
                            let newActivityData = ActivityData(tags: tags, imageTitle: imageTitle, imageDescription: imageDescription, imageData: imageData)
                            modelContext.insert(newActivityData)
                            try? modelContext.save()
                            dismiss()
                        }
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(imageTitle.isEmpty || imageData.isEmpty ? .gray : .blue)
                    .disabled(imageTitle.isEmpty || imageData.isEmpty)
                }
            } // toolbar
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.black, for: .navigationBar)
        } // NavigationStack
        .interactiveDismissDisabled(true)
    }
}

#Preview {
    AddData()
}

//
//  AddDataView.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI
import SwiftData

struct AddData: View {
    @Environment(\.colorScheme) var scheme
    
    @FocusState private var fieldIsFocused: Bool
    
    @State var activityData: ActivityData? = nil // 기존 activityData 수정 시
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    // activityData Model의 파라미터
    @State var timeSlot: TimeSlot = .morning
    @State var tag: Tag = .tennis
    @State var imageTitle: String = ""
    @State var imageDescription: String = ""
    @State var imageData: [Data] = []
    
    var body: some View {
        // 상단 View
        NavigationStack {
            
            Form {
                Section() {
                    VStack {
                        if !imageData.isEmpty {
                            // 사진 미리보기
                            TabView {
                                ForEach(0..<imageData.count, id: \.self) { index in
                                    if let uiImage = UIImage(data: imageData[index]) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                    }
                                }
                            }
                            .frame(height: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 13))
                            .tabViewStyle(.page(indexDisplayMode: .automatic))
                            
                            Button(role: .destructive, action: {
                                withAnimation { imageData = [] }
                            }) {
                                Label("사진 모두 지우기", systemImage: "trash")
                                    .font(.headline)
                                    .foregroundStyle(.red)
                                    .padding(.vertical, 14)
                                    .padding(.horizontal, 18)
                                    .background(Color.red.opacity(0.2))
                                    .cornerRadius(20)
                                    .padding(.vertical, 5)
                            }
                            .buttonStyle(.plain)
                        } else {
                            PhotoPicker(imageData: $imageData)
                                .foregroundStyle(.blue)
                                .buttonStyle(.plain)
                            Text("다양한 Activity 사진을 선택하세요.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.top, 1)
                        }
                    }
                    .frame(maxWidth: .infinity) // Section 내 가운데 정렬을 위해, VStack 너비 확장
                }
                
                Section("제목") {
                    TextField("어떤 활동을 하셨나요?", text: $imageTitle)
                        .focused($fieldIsFocused)
                        .onSubmit {
                            fieldIsFocused.toggle()
                        }
                }
                Section("내용") {
                    TextField("자세한 내용을 기록해보세요.", text: $imageDescription)
                        .focused($fieldIsFocused)
                        .onSubmit {
                            fieldIsFocused.toggle()
                        }
                }
                
                Section("태그") {
                    Picker("시간대", selection: $timeSlot) {
                        ForEach(TimeSlot.selectableCases, id: \.self) { eachTimeSlot in
                            Text(eachTimeSlot.rawValue).tag(eachTimeSlot)
                        }
                    }
                    
                    Picker("종목", selection: $tag) {
                        ForEach(Tag.allCases, id: \.self) { eachTag in
                            Text(eachTag.rawValue).tag(eachTag)
                        }
                    }
                }
            }
//            .onTapGesture {
//                hideKeyboard()
//            }
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
                            activityData.timeSlot = timeSlot
                            activityData.tag = tag
                            activityData.imageTitle = imageTitle
                            activityData.imageDescription = imageDescription
                            activityData.imageData = imageData
                            
                            try? modelContext.save()
                            dismiss()
                        } else { // 새 activityData를 추가할 때
                            let newActivityData = ActivityData(timeSlot: timeSlot, tag: tag, imageTitle: imageTitle, imageDescription: imageDescription, imageData: imageData)
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
        } // NavigationStack
        .interactiveDismissDisabled(true)
    }
}

#Preview {
    AddData()
}

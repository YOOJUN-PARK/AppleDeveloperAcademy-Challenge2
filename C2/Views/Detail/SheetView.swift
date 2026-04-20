//
//  SheetView.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI
import SwiftData
//import Zoomable

struct SheetView: View {
    @Environment(\.colorScheme) var scheme
    
    let activityData: ActivityData
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // ActivityData 수정을 위한 Sheet
    @State private var showingAddData = false
    // ActivityData 삭제를 위한 Alert
    @State private var showingAlert = false
    
    // Image 확대를 위한 Scale
    @GestureState private var magnifyBy = 1.0
    // Image Drag를 위한
    @State private var dragOffset = CGSize.zero
    
    var body: some View {
        ZStack {
            //Color.black.ignoresSafeArea()
            
            VStack {
                // Image와 상단 Dismiss Button
                ZStack {
                    // Activity Image 로딩
                    if !activityData.imageData.isEmpty {
                        TabView {
                            ForEach(0..<activityData.imageData.count, id: \.self) { index in
                                if let uiImage = UIImage(data: activityData.imageData[index]) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .scaleEffect(magnifyBy)
                                        .offset(dragOffset)
                                        .animation(.interactiveSpring(), value: dragOffset)
                                }
                            }
                        }
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                        .tabViewStyle(.page(indexDisplayMode: .automatic))
                    } else {
                        Color.gray
                    }
                    
                    // dismiss Button
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: { dismiss() }) {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                            }
                            .padding(.top, 15)
                            .padding(.trailing, 15)
                        }
                        Spacer()
                    }
                }
                .simultaneousGesture(
                    MagnifyGesture()
                        .updating($magnifyBy) { value, gestureState, transaction in
                            gestureState = value.magnification
                        }
                    
                )
                .simultaneousGesture(
                    DragGesture()
                        .onChanged { gesture in
                            if magnifyBy > 1.0 {
                                dragOffset = gesture.translation
                            }
                        }
                        .onEnded { gesture in
                            dragOffset = .zero
                        }
                )
                .zIndex(1)
                
                // Text
                VStack(alignment: .leading, spacing: 10) {
                    Text(activityData.imageTitle) // Title
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.lightBlack(scheme: scheme))
                    Text(activityData.imageDescription) // Description
                        .font(.subheadline)
                        .foregroundStyle(Color.lightBlack(scheme: scheme))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 15)
                .padding(.horizontal, 29)
                
                // Buttons
                HStack {
                    // activityData edit
                    Button(action: {
                        showingAddData.toggle()
                    }) {
                        Label("수정하기", systemImage: "pencil.line")
                            .font(.headline)
                            .padding(.vertical, 17)
                            .padding(.horizontal, 40)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(20)
                    }
                    .padding(.trailing, 15)
                    .sheet(isPresented: $showingAddData) {
                        AddData(activityData: activityData, tags: activityData.tags, imageTitle: activityData.imageTitle, imageDescription: activityData.imageDescription, imageData: activityData.imageData)
                    }
                    
                    // activityData delete
                    Button(role: .destructive, action: {
                        showingAlert.toggle()
                    }) {
                        Label("삭제하기", systemImage: "trash")
                            .font(.headline)
                            .padding(.vertical, 17)
                            .padding(.horizontal, 40)
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(20)
                    }
                    .alert("Activity 삭제? 질문.", isPresented: $showingAlert) {
                        Button("삭제하기", role: .destructive) {
                            modelContext.delete(activityData)
                            dismiss() // Sheet 닫기
                        }
                        Button("취소", role: .cancel) { }
                    }
                } // HStack - Buttons
            } // VStack
            
        } // ZStack
    } // body
    
}

#Preview {
    SheetView(activityData: testData7)
}

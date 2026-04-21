//
//  ActivityDetailView.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI
import SwiftData
import MapKit

struct ActivityDetailView: View {
    @Environment(\.colorScheme) var scheme
    
    let activityData: ActivityData
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    // ActivityData 수정을 위한 Sheet
    @State private var showingAddData = false
    // ActivityData 삭제를 위한 Alert
    @State private var showingAlert = false
    
    @State private var mapPosition: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: .school,
            distance: 1200,
            heading: 0,
            pitch: 0
        )
    )
    
    var body: some View {
        VStack {
            // Image
            if !activityData.imageData.isEmpty {
                TabView {
                    ForEach(0..<activityData.imageData.count, id: \.self) { index in
                        if let uiImage = UIImage(data: activityData.imageData[index]) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                }
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 13))
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                .padding(.horizontal, 2)
                .padding(.top, 5)
            } else {
                Color.gray
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 13))
                    .padding(.horizontal, 2)
                    .padding(.top, 5)
            }
            
            // UserInfo, Tags
            HStack() {
                Text("UserName")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                FilterButton(text: activityData.timeSlot.rawValue, icon: "", isSelected: false, action: {})
                FilterButton(text: activityData.tag.rawValue, icon: activityData.tag.iconName, isSelected: false, action: {})
                
                Spacer()
            }
            .padding(.top, 5)
            .padding(.horizontal, 20)
            
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
            .padding(.top, 5)
            .padding(.horizontal, 20)
            
            Map(position: $mapPosition) {
                Marker("school", coordinate: .school)
                    .annotationTitles(.hidden)
            }
            .cornerRadius(13)
            .padding(.top, 3)
            .padding(.bottom, 10)
            .padding(.horizontal, 15)
            
        } // VStack
        
        .navigationTitle("자세히 보기")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            ToolbarSpacer(.flexible, placement: .bottomBar)
            
            ToolbarItem(placement: .bottomBar) {
                Button(action: { showingAddData.toggle() }) {
                    Image(systemName: "pencil")
                        .foregroundStyle(Color.blue)
                        .fontWeight(.medium)
                }
                .sheet(isPresented: $showingAddData) {
                    AddActivityView(activityData: activityData, tag: activityData.tag, imageTitle: activityData.imageTitle, imageDescription: activityData.imageDescription, imageData: activityData.imageData)
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button(action: { showingAlert.toggle() }) {
                    Image(systemName: "trash")
                        .foregroundStyle(Color.red)
                        .fontWeight(.medium)
                }
                .alert("Activity 삭제? 질문.", isPresented: $showingAlert) {
                    Button("삭제하기", role: .destructive) {
                        modelContext.delete(activityData)
                        dismiss() // Sheet 닫기
                    }
                    Button("취소", role: .cancel) { }
                }
            }
        }
        
    } // body
    
}

#Preview {
    ActivityDetailView(activityData: testData4)
}

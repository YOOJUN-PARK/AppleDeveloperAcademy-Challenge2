//
//  ContentView.swift
//  C1
//
//  Created by YOOJUN PARK on 3/24/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.colorScheme) var scheme
    
    // 전체 ActivityData -> allActivities
    @Query private var allActivities: [ActivityData]
    
    // 현재 Filtered 된 Tag 정보
    @State private var selectedTag: Tag? = nil
    
    // Filter로 selected 된 ActivityData -> filterdActivities
    var filterdActivities: [ActivityData] {
        if let tag = selectedTag {
            return allActivities.filter {$0.tags.contains(tag)}
        } else {
            return allActivities
        }
    }
    
    // Sheet View를 위해, 현재 선택된 ActivityData Class의 포인터 저장
    @State private var selectedActivity: ActivityData? = nil
    
    // ActivityData 추가를 위한 Sheet
    @State private var showingAddData = false
    
    var body: some View {
        ZStack {
            //Color.black.ignoresSafeArea()
            VStack { // 상단 View, Filter, CardView
                // 상단 View
                HStack {
                    LogoTitle()
                    Spacer()
                    Button(action: { // ActivityData 추가 버튼
                        showingAddData.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 50))
                            .foregroundStyle(.white)
                    }
                    .sheet(isPresented: $showingAddData) {
                        AddData()
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 3)
                
                // Filter Scroll View
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 11) {
                        ForEach(Tag.allCases, id: \.self) { tag in
                            FilterButton(text: tag.rawValue, icon: tag.iconName, isSelected: tag == selectedTag) {
                                // selectedTag가 바뀔 때, selectedTag와 연관된 View들을 다시 계산하여 반환
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    if selectedTag == tag {
                                        selectedTag = nil
                                    } else {
                                        selectedTag = tag
                                    }
                                } // withAnimation
                            } // FilterButton의 action 부분
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, 15)
                .padding(.bottom, 5)
                
                // filterdActivities 위한 Card View
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(spacing: 20) {
                        ForEach(filterdActivities.reversed()) { activityData in
                            ActivityCard(activityData: activityData, selectedActivity: $selectedActivity)
                        }
                    }
                    .padding(.horizontal)
                }
            } // VStack
        } // ZStack
        
        // SheetView: selectedActivity에 값이 들어오면 발생
        .sheet(item: $selectedActivity) {
            activityData in SheetView(activityData: activityData)
                .presentationDragIndicator(.visible)
        }
        
    } // body
    
}

#Preview {
    ContentView()
}

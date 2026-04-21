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
    @State private var selectedTimeSlot: TimeSlot = .all
    @State private var selectedTag: Tag? = nil
    
    
    // Filter로 selected 된 ActivityData -> filterdActivities
    var filterdActivities: [ActivityData] {
        let searchedActivities = searchText.isEmpty ? allActivities : allActivities.filter({$0.imageTitle.contains(searchText)})
        
        if selectedTimeSlot == .all {
            if let selectedTag {
                return searchedActivities.filter({$0.tag == selectedTag})
            } else {
                return searchedActivities
            }
        } else {
            if let selectedTag {
                return searchedActivities.filter({$0.timeSlot == selectedTimeSlot}).filter({$0.tag == selectedTag})
            } else {
                return searchedActivities.filter({$0.timeSlot == selectedTimeSlot})
            }
        }
    }
    
    // Sheet View를 위해, 현재 선택된 ActivityData Class의 포인터 저장
    @State private var selectedActivity: ActivityData? = nil
    
    // ActivityData 추가를 위한 Sheet
    @State private var showingAddData = false
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack { // 상단 View, Filter, CardView
                // 상단 View
                HStack {
                    LogoTitle()
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 1)
                
                // Filter Scroll View
                HStack {
                    SegmentFilterButton(selectedTimeSlot: $selectedTimeSlot)
                    
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(width: 1.5, height: 24)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 9) {
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
                    }
                    .mask(
                        HStack(spacing: 0) {
                            
                            Rectangle().fill(Color.black)
                            
                            LinearGradient(
                                colors: [.black, .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: 24)
                        }
                    )
                }
                .padding(.leading, 15)
                .padding(.bottom, 1)
                
                ZStack {
                    if scheme == .light {
                        Color(.white).cornerRadius(30).ignoresSafeArea()
                    } else {
                        Color(.systemGray6).cornerRadius(30).ignoresSafeArea()
                    }
                    
                    // filterdActivities 위한 Card View
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(spacing: 20) {
                            ForEach(filterdActivities.reversed()) { activityData in
                                ActivityCard(activityData: activityData, selectedActivity: $selectedActivity)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.top, 20)
                }
                
            } // VStack
            .background(scheme == .light ? Color(.systemGray6) : .black)
            
            // SheetView: selectedActivity에 값이 들어오면 발생
            .sheet(item: $selectedActivity) {
                activityData in SheetView(activityData: activityData)
                    .presentationDragIndicator(.visible)
            }
            
            .sheet(isPresented: $showingAddData) {
                AddData()
            }
            
            .toolbar(.hidden, for: .navigationBar)
            .searchable(text: $searchText, prompt: "검색")
            .toolbar {
                DefaultToolbarItem(kind: .search, placement: .bottomBar)
                ToolbarSpacer(.flexible, placement: .bottomBar)
                ToolbarItem(placement: .bottomBar) {
                    Button(action: { showingAddData.toggle() }) {
                        Image(systemName: "plus")
                            .foregroundStyle(Color.blue)
                            .fontWeight(.semibold)
                    }
                }
            }
        } // NavigationStack
        
        
    } // body
    
}

#Preview {
    ContentView()
}

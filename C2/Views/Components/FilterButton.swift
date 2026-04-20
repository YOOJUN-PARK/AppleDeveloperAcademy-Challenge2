//
//  FilterButton.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI

struct FilterButton: View {
    @Environment(\.colorScheme) var scheme
    
    let text: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void // Button 수행 시 동작은 호출 때 파라미터로 받아옴
    
    var body: some View {
        Button(action: action) {
            Label(text, systemImage: icon)
                .font(.system(size: 15))
                .foregroundStyle(isSelected ? .blue : .lightBlack(scheme: scheme))
                .fontWeight(isSelected ? .bold : .semibold)
                .padding(.horizontal, 12)
                .padding(.vertical, 6.2)
                .background(isSelected ? Color(.blue).opacity(0.2) : Color(.systemGray5).opacity(0.7))
                .cornerRadius(90)
        }
    }
}

struct SegmentFilterButton: View {
    
    @Binding var selectedTimeSlot: TimeSlot
    
    var body: some View {
        Picker("TimeSlot", selection: $selectedTimeSlot) {
            Text("전체").tag(TimeSlot.all)
            Text("☀️").tag(TimeSlot.morning)
            Text("🌔").tag(TimeSlot.evening)
        }
        .pickerStyle(.segmented)
        .frame(width: 110, height: 10)
    }
}

#Preview {
    @Previewable @State var selectedTimeSlot: TimeSlot = .all
    HStack {
        FilterButton(text: "Test1", icon: "sun.max", isSelected: true) {}
        FilterButton(text: "Test2", icon: "car", isSelected: false) {}
        SegmentFilterButton(selectedTimeSlot: $selectedTimeSlot)
    }
}

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
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(isSelected ? .blue : .lightBlack(scheme: scheme))
                .padding(.horizontal, 18)
                .padding(.vertical, 10)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(100)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        HStack {
            FilterButton(text: "Test1", icon: "sun.max", isSelected: true) {}
            FilterButton(text: "Test2", icon: "car", isSelected: false) {}
        }
    }
}

//
//  PhotoPicker.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI
import PhotosUI


struct PhotoPicker: View {
    @Binding var imageData: [Data] // 선택 이미지 매핑
    
    @State var selectedItems: [PhotosPickerItem] = []
    
    var body: some View {
        PhotosPicker(selection: $selectedItems, maxSelectionCount: 1, selectionBehavior: .ordered, matching: .images) {
            Label("사진 선택하기", systemImage: "photo.on.rectangle.angled.fill")
                .font(.headline)
                .padding(.vertical, 17)
                .padding(.horizontal, 40)
                .background(Color.blue.opacity(0.2))
                .cornerRadius(20)
        }
        .onChange(of: selectedItems) { oldValue, newValue in
            Task {
                var loadedData: [Data] = []
                
                for item in newValue {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        loadedData.append(data)
                    }
                }
                await MainActor.run {
                    self.imageData = loadedData
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var imageData: [Data] = []
    ZStack {
        Color.black.ignoresSafeArea()
        PhotoPicker(imageData: $imageData)
    }
}

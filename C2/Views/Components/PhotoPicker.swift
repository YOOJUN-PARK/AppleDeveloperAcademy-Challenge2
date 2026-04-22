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
        PhotosPicker(selection: $selectedItems, maxSelectionCount: 3, selectionBehavior: .ordered, matching: .images) {
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

struct ProfilePhotoPicker: View {
    @Binding var imageData: Data? // 선택 이미지 매핑
    @State var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 34))
                .foregroundStyle(.blue)
                .background(Color.white.clipShape(Circle()))
            
        }
        .onChange(of: selectedItem) { oldValue, newValue in
            Task {
                if let data = try? await newValue?.loadTransferable(type: Data.self) {
                    await MainActor.run {
                        self.imageData = data
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var imageData: [Data] = []
    @Previewable @State var profile: Data? = nil
    
    HStack(spacing: 20) {
        PhotoPicker(imageData: $imageData)
        ProfilePhotoPicker(imageData: $profile)
    }
}

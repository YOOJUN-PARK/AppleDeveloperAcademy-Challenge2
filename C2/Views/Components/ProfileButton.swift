//
//  ProfileButton.swift
//  C2
//
//  Created by YOOJUN PARK on 4/22/26.
//

import SwiftUI

struct ProfileButton: View {
    @Environment(\.colorScheme) var scheme
    
    let userImage: Data?
    let action: () -> Void // Button 수행 시 동작은 호출 때 파라미터로 받아옴
    
    var body: some View {
        Button(action: action) {
            if let imageData = userImage,
               let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.systemGray4), lineWidth: 2.5))
            } else {
                Color.gray
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.systemGray4), lineWidth: 2.5))
            }
        }
    }
}

#Preview {
    @Previewable @State var userImage: Data? = nil
    ProfileButton(userImage: nil, action: {})
}

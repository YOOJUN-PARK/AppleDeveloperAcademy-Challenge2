//
//  UserInfoView.swift
//  C2
//
//  Created by YOOJUN PARK on 4/22/26.
//

import SwiftUI
import SwiftData

struct UserInfoView: View {
    @Environment(\.colorScheme) var scheme
    
    @FocusState private var fieldIsFocused: Bool
    
    @State var userData: UserData? = nil
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var allActivities: [ActivityData]
    
    // UserData Model의 파라미터
    @State var userName: String = ""
    @State var userImage: Data? = nil
    
    var body: some View {
        NavigationStack {
            
            VStack(spacing: 0) {
                
                // Profile Image
                ZStack(alignment: .bottomTrailing) {
                    if let imageData = userImage,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else {
                        Color.gray
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    }
                    
                    ProfilePhotoPicker(imageData: $userImage)
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemGroupedBackground))
                
                Form {
                    Section("이름") {
                        TextField("닉네임을 입력하세요", text: $userName)
                            .focused($fieldIsFocused)
                            .onSubmit {
                                fieldIsFocused.toggle()
                            }
                    }
                }
                .background(Color(.systemGroupedBackground))
                .onTapGesture { hideKeyboard() }
                
                Button("초기화") {
                    for activity in allActivities {
                        modelContext.delete(activity)
                    }
                    for data in makeDummyData() {
                        modelContext.insert(data)
                    }
                    try? modelContext.save()
                }
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGroupedBackground))
            }
            
            .navigationTitle("내 프로필")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("저장") {
                        if let userData = userData {
                            userData.userName = userName
                            userData.userImage = userImage
                            try? modelContext.save()
                        }
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundStyle(userName.isEmpty ? .gray : .blue)
                    .disabled(userName.isEmpty)
                }
            } // toolbar
        } // NavigationStack
    }
}

#Preview {
    UserInfoView()
}

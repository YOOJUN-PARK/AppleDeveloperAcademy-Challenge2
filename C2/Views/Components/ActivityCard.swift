//
//  ActivityCard.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI
import SwiftData

// Activity 정보를 표시할 CardView
struct ActivityCard: View {
    let activityData: ActivityData
    
    // Sheet View를 위한, 선택된 ActivityData 정보
    @Binding var selectedActivity: ActivityData?
    
    var body: some View {
        Button(action: {
            selectedActivity =  activityData // .sheet를 위한 trigger
        }) {
            ZStack() {
                // Activity Image 로딩
                if let data = activityData.imageData.first,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .frame(width: 360, height: 450)
                } else {
                    Color.gray
                        .frame(width: 360, height: 450)
                }
                
                // Activity Image 위에 gradient 오버레이
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.clear,
                        Color.black.opacity(0.6)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                
                // Activity Image 위에 Button과 Text 오버레이
                VStack(alignment: .leading, spacing: 8) {
                    Spacer()
                    
                    // Title and Button
                    HStack {
                        Text(activityData.imageTitle) // Title
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .lineLimit(1)
                        
                        Image(systemName: "chevron.right") // moreButton
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    // Description
                    Text(activityData.imageDescription)
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.7))
                        .lineLimit(2)
                }
                .frame(maxWidth: 320, alignment: .leading)
                .padding(.bottom, 22)
                
            } // ZStack
            .frame(width: 360, height: 450)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        } // Button
        .buttonStyle(CardButtonStyle())
        
    } // body
    
    struct CardButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .scaleEffect(configuration.isPressed ? 0.90 : 1.0)
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: configuration.isPressed)
        }
    }
}

#Preview {
    @Previewable @State var selectedActivity: ActivityData? = nil
    
    ActivityCard(activityData: testData8, selectedActivity: $selectedActivity)
    
}

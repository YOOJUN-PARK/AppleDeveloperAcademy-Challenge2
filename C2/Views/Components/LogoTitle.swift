//
//  LogoTitle.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI

struct LogoTitle: View {
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        Text("Open\nActivity")
            .font(.title)
            .fontWeight(.bold)
            .foregroundStyle(Color.lightBlack(scheme: scheme))
    }
}

#Preview {
    LogoTitle()
}

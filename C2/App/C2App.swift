//
//  C2App.swift
//  C2
//
//  Created by YOOJUN PARK on 4/15/26.
//

import SwiftUI
import SwiftData

@main
struct C2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ActivityData.self, UserData.self])
    }
}

//
//  Extensions.swift
//  C2
//
//  Created by YOOJUN PARK on 4/20/26.
//

import SwiftUI

extension Color {
    static func lightBlack(scheme: ColorScheme) -> Color {
        switch scheme {
        case .light: return .black
        case .dark: return .white
        @unknown default: return .black
        }
    }
}

extension Color {
    static func lightWhite(scheme: ColorScheme) -> Color {
        switch scheme {
        case .light: return .white
        case .dark: return .black
        @unknown default: return .white
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

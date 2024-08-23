//
//  CustomPickerModifier.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 23/8/24.
//

import SwiftUI

struct CustomPickerModifier: ViewModifier {
    func body(content: Content)  -> some View {
        content
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color.clear)
            .cornerRadius(8)
        
    }
}
extension View {
    func customPickerStye() -> some View {
        modifier(CustomPickerModifier())
    }
}



//
//  Helpers.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/9/24.
//

import Foundation
import SwiftUI

struct PlainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}


struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
            .overlay(
                       RoundedRectangle(cornerRadius: 8)
                           .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                   )
    }
}

extension View {
    func customTextFieldStyle() -> some View {
        self.modifier(TextFieldStyle())
    }
}

//
//  CustomSeparator.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 2/9/24.
//

import SwiftUI

struct CustomSeparator: ViewModifier {
    func body(content: Content) -> some View {
        Spacer(minLength: 2)
    
        Text("•")
            .font(.largeTitle)
            .fixedSize()
            .padding(.horizontal, 5)
            .padding(.bottom, 5)
        
        Spacer(minLength: 2)
    }
}


extension View {
    func customSeparatorStyle() -> some View {
        modifier(CustomSeparator())
    }
}

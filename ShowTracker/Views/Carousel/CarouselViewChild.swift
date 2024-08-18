//
//  CarouselViewChild.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//

import SwiftUI

struct CarouselViewChild: View, Identifiable {
    var id: Int
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }

    }
}




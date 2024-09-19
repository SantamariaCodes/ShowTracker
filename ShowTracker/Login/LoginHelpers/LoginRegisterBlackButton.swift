////
////  LoginRegisterBlackButton.swift
////  ShowTracker
////
////  Created by Diego Santamaria on 17/9/24.
////
//
import Foundation
import SwiftUI

struct LoginRegisterBlackButton: View {
    var title: String
    
    var body: some View {
        Text(title)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.cyan.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: .black, radius: 1)
            .fontWeight(.bold)

    }
}

#Preview {
    LoginRegisterBlackButton(title: "Login")
}

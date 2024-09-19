////
////  LoginRegisterWhiteButton.swift
////  ShowTracker
////
////  Created by Diego Santamaria on 17/9/24.
////
//
import SwiftUI

struct LoginRegisterWhiteButton: View {
    var title: String
    
    var body: some View {
        Text(title)
            .padding()
            .frame(width: 300, height: 50)
            .background(Color.gray)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .cornerRadius(10)


            .overlay(
                         RoundedRectangle(cornerRadius: 10)
                             .stroke(Color.black, lineWidth: 1)
                     )
    }
}

#Preview {
    LoginRegisterWhiteButton(title: "Register")
}

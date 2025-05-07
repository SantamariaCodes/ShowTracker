//
//  LoginMessageView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/4/25.
//

import SwiftUI

struct LoginMessageView: View {
    let message: String
    let isSuccess: Bool

    var body: some View {
        Text(message)
            .foregroundColor(isSuccess ? .green : .red)
            .padding()
            .background(Color.gray.opacity(0.8))
            .cornerRadius(8)
            .padding(.top)
            .transition(.opacity)
    }
}




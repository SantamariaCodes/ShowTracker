//
//  AuthLinkView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/9/24.
//

import SwiftUI

struct AuthLinkView: View {
    enum AuthLinkType {
        case continueAsGuest
        case register
        case login
    }
    
    var type: AuthLinkType
    var destination: AnyView
    
    private var fullText: String {
        switch type {
        case .continueAsGuest:
            return "Continue as guest"
        case .register:
            return "Don't have an account? Register now"
        case .login:
            return "Already have an account? Login now"
        }
    }
    
    private var highlightedText: String {
        switch type {
        case .continueAsGuest:
            return "Continue as guest"
        case .register:
            return "Register now"
        case .login:
            return "Login now"
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if type != .continueAsGuest {
                Text(fullText.replacingOccurrences(of: highlightedText, with: ""))
            }
            NavigationLink(destination: destination) {
                Text(highlightedText)
                    .foregroundColor(.cyan)
                    .underline()
            }
            .buttonStyle(PlainButtonStyle()) // Remove default button styling
        }
        .font(.callout)
    }
}

#Preview {
    AuthLinkView(type: .register, destination: AnyView(Text("Register View")))
    }

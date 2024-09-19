//
//  LoginDivider.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/9/24.
//

import SwiftUI

struct LoginDivider: View {
    
    enum AuthLinkType {
        case register
        case login
    }
    
    var type: AuthLinkType
    
    private var cases: String {
        switch type {
        case .register:
            "register with"
        case .login:
            "Or login with"
        }
    }
    
    
    var body: some View {
        
        HStack {
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .padding(.horizontal)
            Text(cases)
            
            Rectangle()
                .fill(Color.gray)
                .frame(height: 1)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity) // Take full width


    }
}

#Preview {
    LoginDivider(type: .login)
}

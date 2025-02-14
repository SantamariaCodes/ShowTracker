//
//  AuhtView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

//  AuhtView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 25/9/24.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                
                if authManager.authMethod == .none {
                    emailLoginViews()
                    tmdbLoginButton()
                }
                else if authManager.authMethod == .firebase { emailLoginViews() }
                else if authManager.authMethod == .tmdb {  tmdbLoginButton() }
                
            }
            .padding()
        }
    }
}

private func emailLoginViews() -> some View {
      AuthenticatedView {
      } content: {
        Welcome()
      }
}

private func tmdbLoginButton() -> some View {
    TmdbAccessView(viewModel:AuthViewModel.make())

}




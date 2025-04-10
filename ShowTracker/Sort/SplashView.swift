//
//  SplashView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 6/4/25.
//

import SwiftUI
import FirebaseAuth

struct SplashView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var localFavoriteService: LocalFavoriteService
    @State private var isActive = false

    var body: some View {
        if isActive {
            MainView()
                .environmentObject(authManager)
                .environmentObject(localFavoriteService)
        } else {
            VStack {
                Image("ShowTrackerLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 400)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let identifier = authManager.authMethod == .firebase ? (Auth.auth().currentUser?.email ?? "default") : "default"
                    localFavoriteService.updateUserID(identifier)

                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

//
//  MainView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 18/8/24.
//


import SwiftUI

struct MainView: View {
    @StateObject private var authViewModel = AuthViewModel(authenticationService: AuthenticationService(networkManager: NetworkManager<AuthenticationTarget>()))
    @StateObject private var userAccountViewModel = UserAccountViewModel(userAccountService: UserAccountService(networkManager: NetworkManager<UserAccountTarget>()))

    @State private var showLoginSuccessMessage = false

    var body: some View {
        ZStack {
            TabView {
                TvShowView(viewModel: TvShowListViewModel.make())
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }

                UserFavoritesView(authViewModel: authViewModel, userAccountViewModel: userAccountViewModel)
                    .tabItem {
                        Image(systemName: "star.fill")
                        Text("Favorites")
                    }

                UserDetailsView(authViewModel: authViewModel, userAccountViewModel: userAccountViewModel, onLoginSuccess: {
                    showLoginSuccessMessage = true
                })
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            }

            // Centered Success Message
            if showLoginSuccessMessage {
                VStack {
                    Spacer()
                    Text("Successfully Logged In!")
                        .padding()
                        .background(Color.green.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                        .transition(.opacity)
                        .animation(.easeOut)
                    Spacer() 
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showLoginSuccessMessage = false
                    }
                }
            }
        }
    }
}


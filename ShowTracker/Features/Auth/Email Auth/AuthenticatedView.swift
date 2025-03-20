//
//  AuthenticatedView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 23/1/25.
//


import SwiftUI
import AuthenticationServices


struct AuthenticatedView<Content, Unauthenticated>: View where Content: View, Unauthenticated: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @State private var presentingLoginScreen = false

    var unauthenticated: Unauthenticated?
    @ViewBuilder var content: () -> Content

    public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = unauthenticated
        self.content = content
    }

    public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated,
                @ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = unauthenticated()
        self.content = content
    }

    var body: some View {
        switch viewModel.authenticationState {
        case .unauthenticated, .authenticating:
            VStack {
                if let unauthenticated = unauthenticated {
                    unauthenticated
                }
                Button("Tap here to log in with email") {
                    viewModel.reset()
                    presentingLoginScreen.toggle()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .sheet(isPresented: $presentingLoginScreen) {
                // Present your AuthenticationView which handles email login.
                AuthenticationView()
                    .environmentObject(viewModel)
            }
        case .authenticated:
            VStack {
                content()
                    .environmentObject(viewModel)
                // Optionally add a logout button that uses AuthManager.
                Button("Logout") {
                    AuthManager.shared.logout()
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .onReceive(NotificationCenter.default.publisher(for: ASAuthorizationAppleIDProvider.credentialRevokedNotification)) { _ in
                // Update sign-out behavior upon Apple credential revocation.
                AuthManager.shared.logout()
            }
        }
    }
}

struct AuthenticatedView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView {
            Text("You're signed in.")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(.yellow)
        }
    }
}

extension AuthenticatedView where Unauthenticated == EmptyView {
    init(@ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = nil
        self.content = content
    }
}

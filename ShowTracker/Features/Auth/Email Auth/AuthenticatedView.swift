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
            VStack(spacing: 20) {
                if let unauthenticated = unauthenticated {
                    unauthenticated
                }

                Button(action: {
                    viewModel.reset()
                    presentingLoginScreen.toggle()
                }) {
                    Text("Log in with Email")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: Color.cyan.opacity(0.4), radius: 5, x: 0, y: 4)
                }

            }
            .padding()
            .sheet(isPresented: $presentingLoginScreen) {
                AuthenticationView()
                    .environmentObject(viewModel)
            }

        case .authenticated:
            VStack(spacing: 24) {
                content()
                    .environmentObject(viewModel)
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

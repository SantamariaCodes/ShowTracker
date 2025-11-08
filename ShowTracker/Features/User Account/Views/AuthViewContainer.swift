//
//  AuthViewContainer.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/4/25.
//

import SwiftUI

struct AuthViewContainer: View {
    @ObservedObject var viewModel: UserAccountViewModel

    var body: some View {
        AuthView()
            .onOpenURL { url in handleOpenURL(url) }
        
    }

    private func handleOpenURL(_ url: URL) {
        if url.absoluteString.lowercased().hasSuffix("&approved=true"),
           let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let queryItems = components.queryItems,
           let requestToken = queryItems.first(where: { $0.name == "request_token" })?.value {
            print("Request Token Status: \(requestToken)")
            viewModel.createSession(requestToken: requestToken)
        } else {
        }
    }
}


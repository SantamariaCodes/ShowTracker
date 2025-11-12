//
//  UserDetails.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModel: UserAccountViewModel

    var body: some View {
        VStack {
            viewContent
       
        }
    }

    @ViewBuilder
    private var viewContent: some View {
        ZStack {
            if viewModel.isLoggedIn {
                UserAccountView(viewModel: viewModel)
            } else {
                AuthViewContainer(viewModel: viewModel)
            }

        }
    }
}

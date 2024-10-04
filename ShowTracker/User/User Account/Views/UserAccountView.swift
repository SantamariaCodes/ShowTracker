//
//  UserAccountView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import SwiftUI

import SwiftUI

struct UserAccountView: View {
    @ObservedObject var viewModel: UserAccountViewModel
    var sessionID: String

    var body: some View {
        VStack {
            if let accountDetails = viewModel.accountDetails {
                Text("Welcome, \(accountDetails.username)!")

            

                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
                
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
            } else {
                Text("Loading account details...")
                    .onAppear {
                        viewModel.fetchAccountDetails(sessionID: sessionID)
                    }
            }
        }
    }
}


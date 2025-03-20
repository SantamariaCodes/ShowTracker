//
//  UserAccountView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

//
//  UserAccountView.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 1/10/24.
//

import SwiftUI

struct UserAccountView: View {
    @ObservedObject var viewModel: UserAccountViewModel
    var body: some View {
        VStack {
           
            if let accountDetails = viewModel.accountDetails {
                // Avatar section
                HStack {
                    if let avatarPath = accountDetails.avatar.tmdb.avatar_path {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(avatarPath)")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        AsyncImage(url: URL(string: "https://www.gravatar.com/avatar/\(accountDetails.avatar.gravatar.hash)")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        } placeholder: {
                            ProgressView()
                        }
                    }

                    VStack(alignment: .leading) {
                        Text(accountDetails.username)
                            .font(.title)
                            .fontWeight(.bold)

                        if !accountDetails.name.isEmpty {
                            Text(accountDetails.name)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.leading)
                }
                .padding()

                VStack(alignment: .leading, spacing: 10) {
                    Text("User Info")
                        .font(.headline)
                        .padding(.bottom, 5)

                    HStack {
                        Text("Country:")
                            .fontWeight(.bold)
                        Text(accountDetails.iso_3166_1)
                    }

                    HStack {
                        Text("Language:")
                            .fontWeight(.bold)
                        Text(accountDetails.iso_639_1)
                    }

                    HStack {
                        Text("Include Adult Content:")
                            .fontWeight(.bold)
                        Text(accountDetails.include_adult ? "Yes" : "No")
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding()

                // Error handling
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }

                // Logout button
                Button(action: {
                    viewModel.logout()
                    AuthManager.shared.logout()

                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.top)
                }
            } else if let errorMessage = viewModel.errorMessage {
                // Display error message if user details couldn't be fetched
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                // Display loading indicator while fetching account details
                ProgressView("Loading account details...")
                    .onAppear {
                        viewModel.fetchAccountDetails()
                    }
            }
        }
        .navigationTitle("Account")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

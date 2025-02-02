//
//  Welcome.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 24/1/25.
//

import SwiftUI

struct Welcome: View {
    @State private var presentingProfileScreen = false
    @ObservedObject private var authenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Text("hello")
            }
            .listStyle(.plain)
            .toolbar {
                Button(action: { presentingProfileScreen.toggle() }) {
                    Image(systemName: "person.circle")
                }
            }
            .sheet(isPresented: $presentingProfileScreen) {
                NavigationView {
                    UserProfileView()
                        .environmentObject(authenticationViewModel)
                }
            }
            .navigationTitle("My Favourites")
        }
        
    }
}

#Preview {
    Welcome()
}

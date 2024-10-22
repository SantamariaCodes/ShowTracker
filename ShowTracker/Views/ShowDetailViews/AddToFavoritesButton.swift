//
//  AddToFavoritesButton.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 10/10/24.
//

import Foundation
import SwiftUI

struct AddToFavoritesButton: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
    
    @State private var navigateToUserDetails = false

    var body: some View {
        VStack {
         
            Text("This feature will be added soon!")
            Button(action: {
                navigateToUserDetails = true
            }) {
                Text("Add to Watch List")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: 200)
                    .background(Color.red)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
        
        }
    }
}

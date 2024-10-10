//import Foundation
//import SwiftUI
//
//struct AddToFavoritesButton: View {
//    @EnvironmentObject var authViewModel: AuthViewModel
//    @EnvironmentObject var userAccountViewModel: UserAccountViewModel
//    
//    @State private var navigateToUserDetails = false
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                print("Add to Favorites tapped")
//                navigateToUserDetails = true
//            }) {
//                Text("Add to Favorites")
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: 200)
//                    .background(Color.red)
//                    .cornerRadius(25)
//            }
//            .padding(.horizontal)
//            
//            // NavigationLink that navigates to UserDetailsView using EnvironmentObject
//            NavigationLink(
//                destination: UserDetailsView(),
//                isActive: $navigateToUserDetails
//            ) {
//                EmptyView()
//            }
//        }
//    }
//}

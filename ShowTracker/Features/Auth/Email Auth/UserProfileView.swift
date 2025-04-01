import SwiftUI

struct UserProfileView: View {
    @ObservedObject private var authenticationViewModel = AuthenticationViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var presentingConfirmationDialog = false

    private func deleteAccount() {
        Task {
            if await authenticationViewModel.deleteAccount() {
                dismiss()
            }
        }
    }

    private func signOut() {
        authenticationViewModel.signOut()
        AuthManager.shared.logout()
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Profile Picture
//                VStack {
//                    Image(systemName: "person.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 120, height: 120)
//                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.cyan, lineWidth: 3))
//                        .shadow(radius: 5)
//
//                    Button("Edit", action: {
//                        // Add edit action
//                    })
//                    .font(.caption)
//                    .foregroundColor(.cyan)
//                }
//                .padding(.top, 32)

                // Email Display
                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(authenticationViewModel.displayName)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                // Sign Out Button (Cyan)
                Button(action: signOut) {
                    Text("Sign Out")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.cyan)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .shadow(color: Color.cyan.opacity(0.4), radius: 5, x: 0, y: 4)
                }
                .padding(.horizontal)

                // Delete Account Button missing clearing favorites function
//                Button(role: .destructive) {
//                    presentingConfirmationDialog = true
//                } label: {
//                    Text("Delete Account")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.cyan)
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                        .shadow(color: Color.cyan.opacity(0.4), radius: 5, x: 0, y: 4)
//                }
//                .padding(.horizontal)

                Spacer()
            }
            .padding()
        }
        
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "Deleting your account is permanent. Do you want to delete your account?",
            isPresented: $presentingConfirmationDialog,
            titleVisibility: .visible
        ) {
            Button("Delete Account", role: .destructive, action: deleteAccount)
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserProfileView()
        }
    }
}

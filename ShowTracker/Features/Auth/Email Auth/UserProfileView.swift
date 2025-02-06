import SwiftUI

struct UserProfileView: View {
  @EnvironmentObject var authVM: AuthenticationViewModel
  @Environment(\.dismiss) var dismiss
  @State private var presentingConfirmationDialog = false

  private func deleteAccount() {
    Task {
      if await authVM.deleteAccount() {
        dismiss()
      }
    }
  }

  private func signOut() {
    authVM.signOut()
    AuthManager.shared.logout()

  }

  var body: some View {
    Form {
      Section {
        VStack {
          HStack {
            Spacer()
            Image(systemName: "person.fill")
              .resizable()
              .frame(width: 100, height: 100)
              .aspectRatio(contentMode: .fit)
              .clipShape(Circle())
              .padding(4)
              .overlay(Circle().stroke(Color.accentColor, lineWidth: 2))
            Spacer()
          }
          Button("Edit") {
            // Implement edit functionality if needed.
          }
        }
      }
      .listRowBackground(Color(UIColor.systemGroupedBackground))
      
      Section(header: Text("Email")) {
        Text(authVM.displayName)
      }
      
      Section {
        Button(role: .cancel, action: signOut) {
          HStack {
            Spacer()
            Text("Sign out")
            Spacer()
          }
        }
      }
      
      Section {
        Button(role: .destructive, action: { presentingConfirmationDialog.toggle() }) {
          HStack {
            Spacer()
            Text("Delete Account")
            Spacer()
          }
        }
      }
    }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
    .confirmationDialog(
      "Deleting your account is permanent. Do you want to delete your account?",
      isPresented: $presentingConfirmationDialog,
      titleVisibility: .visible
    ) {
      Button("Delete Account", role: .destructive, action: deleteAccount)
      Button("Cancel", role: .cancel) { }
    }
  }
}

struct UserProfileView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      UserProfileView()
        .environmentObject(AuthenticationViewModel.make())  // using make extension
        .environmentObject(AuthManager.shared)
    }
  }
}

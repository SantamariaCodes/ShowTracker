//
//  AuthenticationViewModel.swift
//  FireTest
//
//  Created by Diego Santamaria on 19/12/24.
//


import Foundation
import FirebaseAuth

enum AuthenticationState {
  case unauthenticated
  case authenticating
  case authenticated
}

enum AuthenticationFlow {
  case login
  case signUp
}

@MainActor
class AuthenticationViewModel: ObservableObject {
  @Published var email = ""
  @Published var password = ""
  @Published var confirmPassword = ""

  @Published var flow: AuthenticationFlow = .login

  @Published var isValid = false
  @Published var authenticationState: AuthenticationState = .unauthenticated
  @Published var errorMessage = ""
  @Published var user: User?
  @Published var displayName = ""

  private var currentNonce: String?

  init() {
    registerAuthStateHandler()

    $flow
      .combineLatest($email, $password, $confirmPassword)
      .map { flow, email, password, confirmPassword in
        flow == .login
        ? !(email.isEmpty || password.isEmpty)
        : !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
      }
      .assign(to: &$isValid)
  }

  private var authStateHandler: AuthStateDidChangeListenerHandle?

  func registerAuthStateHandler() {
    if authStateHandler == nil {
      authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
        self.user = user
        self.authenticationState = user == nil ? .unauthenticated : .authenticated
        self.displayName = user?.displayName ?? user?.email ?? ""
          //ensure that the listener isn't being set up multiple times and that we handle any potential duplicate calls.
          if self.authenticationState == .authenticated {
              AuthManager.shared.loginWithFirebase()
          }
          if self.authenticationState == .unauthenticated {
              AuthManager.shared.logout()
          }
          
      }
    }
  }

  func switchFlow() {
    flow = flow == .login ? .signUp : .login
    errorMessage = ""
  }

  private func wait() async {
    do {
      print("Wait")
      try await Task.sleep(nanoseconds: 1_000_000_000)
      print("Done")
    }
    catch {
      print(error.localizedDescription)
    }
  }

  func reset() {
    flow = .login
    email = ""
    password = ""
    confirmPassword = ""
  }
}

// MARK: - Email and Password Authentication

extension AuthenticationViewModel {
  func signInWithEmailPassword() async -> Bool {
    authenticationState = .authenticating
    do {
      _ = try await Auth.auth().signIn(withEmail: self.email, password: self.password)
      AuthManager.shared.loginWithFirebase()
      return true
    } catch {
      errorMessage = error.localizedDescription
      authenticationState = .unauthenticated
      return false
    }
  }

  func signUpWithEmailPassword() async -> Bool {
    authenticationState = .authenticating
    do {
      _ = try await Auth.auth().createUser(withEmail: email, password: password)
      AuthManager.shared.loginWithFirebase()
      return true
    } catch {
      errorMessage = error.localizedDescription
      authenticationState = .unauthenticated
      return false
    }
  }
}

extension AuthenticationViewModel {
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}



extension AuthenticationViewModel {
    func signOut() {
        do {
            try Auth.auth().signOut()
            authenticationState = .unauthenticated
            user = nil
            displayName = ""
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

extension AuthenticationViewModel {
    static func make() -> AuthenticationViewModel {
        return AuthenticationViewModel()
    }
}



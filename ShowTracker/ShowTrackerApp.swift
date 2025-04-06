//
//  ShowTrackerApp.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/8/24.


import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
//      Auth.auth().useEmulator(withHost:"localhost", port:9099)

    return true
  }
}

@main
struct ShowTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authManager = AuthManager.shared
    @StateObject private var localFavoriteService = LocalFavoriteService()


    
    var body: some Scene {
        WindowGroup {
                SplashView()
                .environmentObject(authManager)
                .environmentObject(localFavoriteService)
            }
        }
    }


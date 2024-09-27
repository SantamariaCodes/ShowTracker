//
//  ShowTrackerApp.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 17/8/24.
//

//import SwiftUI
//
//@main
//struct ShowTrackerApp: App {
//    var body: some Scene {
//        WindowGroup {
//            MainView()
//        }
//    }
//}

import SwiftUI

@main
struct ShowTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            AuthView()
                .onOpenURL { url in
                    // This replaces AppDelegate's `application(_:open:options:)`
                    print("Returned to app with URL: \(url.absoluteString)")

                    // Handle the URL and process the request token
                    if url.absoluteString.hasPrefix("PortfolioApp://approved") {
                        print("Request token approved")
                        // Trigger session creation logic here using the request token
                        // Example: AuthViewModel().createSession(requestToken: token)
                    }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    print("App became active again")
                }
        }
    }
}


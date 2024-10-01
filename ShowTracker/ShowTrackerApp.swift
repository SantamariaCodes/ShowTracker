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
//       one liner             url.absoluteString.lowercased().hasSuffix("&approved=true") ? print("token approved") : print("token denied")
                    
                    if url.absoluteString.lowercased().hasSuffix("&approved=true") {
                        if let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                           let queryItems = components.queryItems {
                            if let requestToken = queryItems.first(where: { $0.name == "request_token" })?.value {
                            
                                print("Request Token: \(requestToken)")
                            } else {
                                print("Request token not found.")
                            }
                        }
                    }
                   
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    print("App became active again")
                }
        }
    }
}


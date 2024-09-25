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
    init() {
        testAuthenticationService()
    }
    
    var body: some Scene {
        WindowGroup {
            Text("Testing Authentication...")
        }
    }

    func testAuthenticationService() {
        let networkManager = NetworkManager<AuthenticationTarget>()
        let authService = AuthenticationService(networkManager: networkManager)

        authService.getRequestToken { result in
            switch result {
            case .success(let requestToken):
                print("Success! Request Token: \(requestToken)")
            case .failure(let error):
                print("Failed to get request token: \(error.localizedDescription)")
            }
        }
    }
}

////// nose que esta pasando
//import UIKit
//
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//    var viewModel: AuthViewModel?
//
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
//        if url.absoluteString.hasPrefix("PortfolioApp://approved") {
//            print("Returned to app with approved request token!")
//
//            if let requestToken = viewModel?.requestToken {
//                
//                viewModel?.createSession(requestToken: requestToken)
//            }
//        }
//        return true
//    }
//}

//
//  SessionManager.swift
//  ShowTracker
//
//  Created by Diego Santamaria on 3/10/24.
//

import Foundation
import SwiftUI

//atempt to store and share data on the whole app
class SessionManager: ObservableObject {
    @Published var sessionID: String?
    @Published var accountID: String?
    
}

//
//  DarkModeManager.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 03/12/2023.
//

import Foundation
import Combine

class DarkModeManager: ObservableObject {
    @Published var isDarkModeEnabled: Bool = false
}

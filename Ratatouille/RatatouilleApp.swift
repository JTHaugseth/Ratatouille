//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI
import SwiftData

@main
struct RatatouilleApp: App {
    @StateObject var darkModeManager = DarkModeManager()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(darkModeManager)
                .preferredColorScheme(darkModeManager.isDarkModeEnabled ? .dark : .light)
        }
        .modelContainer(for: [AreaDbModel.self, CategoryDbModel.self, IngredientDbModel.self, MealDbModel.self])
    }
}

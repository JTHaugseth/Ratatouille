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
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [AreaDbModel.self, CategoryDbModel.self, IngredientDbModel.self, MealDbModel.self])
    }
}

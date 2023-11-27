//
//  IngredientViewModel.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import Foundation

class IngredientViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    private let apiService = ApiService()
    //private let databaseManager = DatabaseManager()

    func loadSavedIngredients() {
        // Load ingredients from SwiftData and update `ingredients`
        //ingredients = databaseManager.fetchAllIngredients()
    }

    func loadIngredientsFromAPI() {
        apiService.fetchIngredients { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ingredients):
                    self?.ingredients = ingredients
                    // Optionally, save new ingredients to SwiftData here
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    // Add other necessary methods, e.g., for saving ingredients to SwiftData
}

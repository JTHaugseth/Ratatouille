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
    
    func loadIngredients() {
        apiService.fetchIngredients { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let ingredients):
                    self?.ingredients = ingredients
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

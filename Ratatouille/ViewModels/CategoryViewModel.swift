//
//  CategoryViewModel.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    private let apiService = ApiService()
    //private let databaseManager = DatabaseManager()

    func loadSavedCategories() {
        // Load categories from SwiftData and update `categories`
        //categories = databaseManager.fetchAllCategories()
    }

    func loadCategoriesFromAPI() {
        apiService.fetchCategories { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self?.categories = categories
                    // Optionally, save new categories to SwiftData here
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    // Add other necessary methods, e.g., for saving categories to SwiftData
}

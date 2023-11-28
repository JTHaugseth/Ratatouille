//
//  CategoryViewModel.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var selectedCategories = Set<String>()
    private let apiService = ApiService()
    
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
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func isSelected(category: Category) -> Bool {
        selectedCategories.contains(category.strCategory)
    }

    func toggleSelection(category: Category) {
        if isSelected(category: category) {
            selectedCategories.remove(category.strCategory)
        } else {
            selectedCategories.insert(category.strCategory)
        }
    }

    func toggleAllSelections() {
        if selectedCategories.count == categories.count {
            selectedCategories.removeAll()
        } else {
            selectedCategories = Set(categories.map { $0.strCategory })
        }
    }

    func importSelectedCategories() {
        // Placeholder for database import logic
        print("Selected categories to import: \(selectedCategories)")
    }
}

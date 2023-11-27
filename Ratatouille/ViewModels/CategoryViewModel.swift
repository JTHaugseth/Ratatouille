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
    
    func loadCategories() {
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
}

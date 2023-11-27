//
//  AreaViewModel.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import Foundation

class AreaViewModel: ObservableObject {
    @Published var areas: [Area] = []
    private let apiService = ApiService()
    //private let databaseManager = DatabaseManager()

    func loadSavedAreas() {
        // Load areas from SwiftData and update `areas`
        //areas = databaseManager.fetchAllAreas()
    }

    func loadAreasFromAPI() {
        apiService.fetchAreas { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let areas):
                    self?.areas = areas
                    // Optionally, save new areas to SwiftData here
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Add other necessary methods, e.g., for saving areas to SwiftData
}

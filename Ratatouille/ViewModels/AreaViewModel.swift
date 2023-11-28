//
//  AreaViewModel.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import Foundation

class AreaViewModel: ObservableObject {
    @Published var areas: [Area] = []
    @Published var selectedAreas = Set<String>()
    private let apiService = ApiService()
    
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
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    func isSelected(area: Area) -> Bool {
        selectedAreas.contains(area.strArea)
    }

    func toggleSelection(area: Area) {
        if isSelected(area: area) {
            selectedAreas.remove(area.strArea)
        } else {
            selectedAreas.insert(area.strArea)
        }
    }

    func toggleAllSelections() {
        if selectedAreas.count == areas.count {
            selectedAreas.removeAll()
        } else {
            selectedAreas = Set(areas.map { $0.strArea })
        }
    }

    func importSelectedAreas() {
        // Placeholder for database import logic
        // This function should handle saving the selectedAreas to your database
        print("Selected areas to import: \(selectedAreas)")
    }
}

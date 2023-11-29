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
    
    let countryNameToCode: [String: String] = [
        "American": "US",
        "British": "GB",
        "Canadian": "CA",
        "Chinese": "CN",
        "Croatian": "HR",
        "Dutch": "NL",
        "Egyptian": "EG",
        "Filipino": "PH",
        "French": "FR",
        "Greek": "GR",
        "Indian": "IN",
        "Irish": "IE",
        "Italian": "IT",
        "Jamaican": "JM",
        "Japanese": "JP",
        "Kenyan": "KE",
        "Malaysian": "MY",
        "Mexican": "MX",
        "Moroccan": "MA",
        "Polish": "PL",
        "Portuguese": "PT",
        "Russian": "RU",
        "Spanish": "ES",
        "Thai": "TH",
        "Tunisian": "TN",
        "Turkish": "TR",
        "Unknown": "", // No code for "Unknown"
        "Vietnamese": "VN"
    ]
    
    func flagURL(for area: Area) -> URL? {
        guard let countryCode = countryNameToCode[area.strArea] else {
            return nil
        }
        return URL(string: "https://flagsapi.com/\(countryCode)/flat/64.png")
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
}

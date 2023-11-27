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
    
    func loadAreas() {
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
}

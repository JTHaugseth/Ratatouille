//
//  ApiService.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import Foundation

class ApiService {
    func fetchMealsByArea(area: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
            let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?a=\(area)"
            fetchItems(urlString: urlString, completion: completion)
        }

    func fetchMealsByCategory(category: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
            let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(category)"
            fetchItems(urlString: urlString, completion: completion)
        }

    func fetchMealsByIngredient(ingredient: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
            let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?i=\(ingredient)"
            fetchItems(urlString: urlString, completion: completion)
        }
    
    func fetchCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CategoryListResponse.self, from: data)
                completion(.success(response.categories))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchAreas(completion: @escaping (Result<[Area], Error>) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
        fetchItems(urlString: urlString, completion: completion)
    }
    
    func fetchIngredients(completion: @escaping (Result<[Ingredient], Error>) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        fetchItems(urlString: urlString, completion: completion)
    }
    
    private func fetchItems<T: Decodable>(urlString: String, completion: @escaping (Result<[T], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let itemsResponse = try decoder.decode(ListResponse<T>.self, from: data)
                completion(.success(itemsResponse.meals))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

struct ListResponse<T: Decodable>: Decodable {
    let meals: [T]
}

struct CategoryListResponse: Decodable {
    let categories: [Category]
}

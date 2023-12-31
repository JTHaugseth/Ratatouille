import Foundation

class IngredientViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    @Published var selectedIngredients = Set<String>()
    private let apiService = ApiService()
    
    func loadIngredientsFromAPI() {
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
    
    func isSelected(ingredient: Ingredient) -> Bool {
        selectedIngredients.contains(ingredient.idIngredient)
    }
    
    func toggleSelection(ingredient: Ingredient) {
        if isSelected(ingredient: ingredient) {
            selectedIngredients.remove(ingredient.idIngredient)
        } else {
            selectedIngredients.insert(ingredient.idIngredient)
        }
    }
    
    func toggleAllSelections() {
        if selectedIngredients.count == ingredients.count {
            selectedIngredients.removeAll()
        } else {
            selectedIngredients = Set(ingredients.map { $0.idIngredient })
        }
    }
    
    func filteredIngredients(_ searchText: String) -> [Ingredient] {
        if searchText.isEmpty {
            return ingredients
        } else {
            return ingredients.filter { $0.strIngredient.lowercased().contains(searchText.lowercased()) }
        }
    }
}

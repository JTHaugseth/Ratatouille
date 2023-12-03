//
//  MealDetailView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 30/11/2023.
//
import SwiftUI
import SwiftData

struct MealDetailView: View {
    let mealId: String
    @State private var mealDetail: MealDetail?
    @State private var isLoading = false
    @Environment(\.modelContext) private var context
    
    private let apiService = ApiService()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if isLoading {
                    ProgressView("Loading...")
                } else if let mealDetail = mealDetail {
                    AsyncImage(url: URL(string: mealDetail.strMealThumb)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    
                    HStack {
                        Text(mealDetail.strMeal)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        // Save Button
                        Button(action: { saveMealToDB(mealDetail) }) {
                            Image(systemName: "square.and.arrow.down")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    if !mealDetail.strCategory.isEmpty && !mealDetail.strArea.isEmpty {
                        Text("\(mealDetail.strCategory) - \(mealDetail.strArea)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                    
                    Text("Ingredients")
                        .font(.headline)
                    ForEach(0..<20, id: \.self) { index in
                        if let ingredient = ingredient(at: index, in: mealDetail),
                           let measure = measure(at: index, in: mealDetail) {
                            Text("• \(ingredient) - \(measure)")
                        }
                    }
                    
                    Divider()
                    
                    Text("Instructions")
                        .font(.headline)
                    Text(mealDetail.strInstructions)
                        .font(.body)
                } else {
                    Text("Meal details not available.")
                }
            }
            .padding()
        }
        .onAppear {
            loadMealDetails()
        }
    }
    
    private func loadMealDetails() {
        isLoading = true
        apiService.fetchMealDetail(mealId: mealId) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let detail):
                    mealDetail = detail
                case .failure(let error):
                    print("Error fetching meal details: \(error)")
                }
            }
        }
    }
    
    private func saveMealToDB(_ meal: MealDetail) {
        let newMeal = MealDbModel()
        newMeal.oldID = meal.idMeal
        newMeal.title = meal.strMeal
        newMeal.instructions = meal.strInstructions
        newMeal.thumb = meal.strMealThumb
        newMeal.youtube = meal.strYoutube ?? ""
        
        // Concatenate ingredients and measures
        let ingredients = (1...20).compactMap { index -> String? in
            guard let ingredient = ingredient(at: index, in: meal),
                  let measure = measure(at: index, in: meal),
                  !ingredient.isEmpty
            else {
                return nil
            }
            return "\(ingredient): \(measure)"
        }.joined(separator: ", ")
        
        newMeal.ingredients = ingredients
        context.insert(newMeal)
        // Save the new meal to the database
        print("Saving meal: \(newMeal.title)")
        
    }
    
    private func ingredient(at index: Int, in meal: MealDetail) -> String? {
        let ingredientProperties = [
            meal.strIngredient1, meal.strIngredient2, meal.strIngredient3, meal.strIngredient4, meal.strIngredient5,
            meal.strIngredient6, meal.strIngredient7, meal.strIngredient8, meal.strIngredient9, meal.strIngredient10,
            meal.strIngredient11, meal.strIngredient12, meal.strIngredient13, meal.strIngredient14, meal.strIngredient15,
            meal.strIngredient16, meal.strIngredient17, meal.strIngredient18, meal.strIngredient19, meal.strIngredient20
        ]
        
        // Check if the index is within the bounds of the array
        guard index >= 0 && index < ingredientProperties.count else {
            return nil
        }
        
        return ingredientProperties[index]?.isEmpty == false ? ingredientProperties[index] : nil
    }
    
    private func measure(at index: Int, in meal: MealDetail) -> String? {
        let measureProperties = [
            meal.strMeasure1, meal.strMeasure2, meal.strMeasure3, meal.strMeasure4, meal.strMeasure5,
            meal.strMeasure6, meal.strMeasure7, meal.strMeasure8, meal.strMeasure9, meal.strMeasure10,
            meal.strMeasure11, meal.strMeasure12, meal.strMeasure13, meal.strMeasure14, meal.strMeasure15,
            meal.strMeasure16, meal.strMeasure17, meal.strMeasure18, meal.strMeasure19, meal.strMeasure20
        ]
        return measureProperties[index]?.isEmpty == false ? measureProperties[index] : nil
    }
}

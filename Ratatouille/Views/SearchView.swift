//
//  SearchView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI
import SwiftData

struct SearchView: View {
    
    @Query(filter: #Predicate<AreaDbModel>{$0.archived == false},
           sort: \AreaDbModel.title, order: .forward, animation: .default) private var savedAreas: [AreaDbModel]
    
    @Query(filter: #Predicate<CategoryDbModel>{$0.archived == false},
           sort: \CategoryDbModel.title, order: .forward, animation: .default) private var savedCategories: [CategoryDbModel]
    
    @Query(filter: #Predicate<IngredientDbModel>{$0.archived == false},
           sort: \IngredientDbModel.title, order: .forward, animation: .default) private var savedIngredients: [IngredientDbModel]
    
    @State private var selectedButtonType: SelectedButtonType? = nil
    @State private var selectedItemTitle: String = ""
    @State private var showDetails = false
    @State private var meals: [Meal] = []

    private let apiService = ApiService()

    var body: some View {
        VStack {
            HStack {
                // Content List
                if !showDetails {
                    switch selectedButtonType {
                    case .area:
                        areaList()
                    case .category:
                        categoryList()
                    case .ingredient:
                        ingredientList()
                    default:
                        Text("Søk etter Oppskrifter")
                    }
                }

                // Details View
                if showDetails {
                    mealListView()
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.default, value: showDetails)

            // Bottom bar with buttons
            HStack {
                Spacer()

                Button(action: {
                    selectedButtonType = .area
                    showDetails = false
                }) {
                    buttonView(systemName: "globe", color: .blue)
                }

                Spacer()

                Button(action: {
                    selectedButtonType = .category
                    showDetails = false
                }) {
                    buttonView(systemName: "list.bullet", color: .green)
                }

                Spacer()

                Button(action: {
                    selectedButtonType = .ingredient
                    showDetails = false
                }) {
                    buttonView(systemName: "leaf", color: .orange)
                }

                Spacer()

                Button(action: {
                    selectedButtonType = .search
                    showDetails = false
                }) {
                    buttonView(systemName: "magnifyingglass", color: .red)
                }

                Spacer()
            }
            .padding(.bottom)
        }
        .animation(.default, value: selectedButtonType)
    }

    // Separate list functions for each type
    private func areaList() -> some View {
        List(savedAreas, id: \.self) { area in
            Button(action: { selectItem(area.title) }) {
                HStack {
                    if let flagURL = URL(string: "https://flagsapi.com/\(area.countrycode)/flat/64.png") {
                        AsyncImage(url: flagURL) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 50)
                    } else {
                        // Fallback if flag URL is not available
                        Color.gray
                            .frame(width: 50, height: 50)
                    }

                    Text(area.title)
                }
            }
        }
        .transition(.move(edge: .leading))
    }

    private func categoryList() -> some View {
        List(savedCategories, id: \.self) { category in
            Button(action: { selectItem(category.title) }) {
                HStack {
                    if let url = URL(string: category.thumb) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                    } else {
                        Color.gray // Fallback placeholder
                            .frame(width: 50, height: 50)
                            .cornerRadius(25)
                    }

                    Text(category.title)
                }
            }
        }
        .transition(.move(edge: .leading))
    }

    private func ingredientList() -> some View {
        List(savedIngredients, id: \.self) { ingredient in
            Button(action: { selectItem(ingredient.title) }) {
                Text(ingredient.title)
            }
        }
        .transition(.move(edge: .leading))
    }

    // Function to handle item selection
        private func selectItem(_ title: String) {
            selectedItemTitle = title
            withAnimation {
                showDetails = true
            }
            fetchMealsForSelectedItem(title)
        }

        // Fetching meals based on the selected item
        private func fetchMealsForSelectedItem(_ title: String) {
            switch selectedButtonType {
            case .area:
                apiService.fetchMealsByArea(area: title) { result in
                    handleFetchResult(result)
                }
            case .category:
                apiService.fetchMealsByCategory(category: title) { result in
                    handleFetchResult(result)
                }
            case .ingredient:
                apiService.fetchMealsByIngredient(ingredient: title) { result in
                    handleFetchResult(result)
                }
            default:
                break
            }
        }

        // Handle the result of the fetch
        private func handleFetchResult(_ result: Result<[Meal], Error>) {
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedMeals):
                    meals = fetchedMeals
                case .failure(let error):
                    print("Error fetching meals: \(error)")
                }
            }
        }

        // Placeholder for the meal list view
    private func mealListView() -> some View {
        VStack {
            Text("Oppskrifter basert på \(selectedItemTitle)")
            List(meals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                    HStack {
                        if let url = URL(string: meal.strMealThumb) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        } else {
                            Color.gray
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                        }

                        // Meal name
                        Text(meal.strMeal)

                    }
                }
            }
            Button("Tilbake") {
                withAnimation {
                    showDetails = false
                }
            }
        }
    }

        // Helper function for button view
        private func buttonView(systemName: String, color: Color) -> some View {
            Image(systemName: systemName)
                .foregroundColor(.white)
                .padding()
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        
        enum SelectedButtonType {
            case area, category, ingredient, search
        }
    }

#Preview {
    SearchView()
}



    

//
//  MyIngredientsView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 28/11/2023.
//

import SwiftUI
import SwiftData

struct MyIngredientsView: View {
    @ObservedObject var viewModel = IngredientViewModel()
    
    @Query(filter: #Predicate<IngredientDbModel>{$0.archived == false},
           sort: \IngredientDbModel.title, order: .forward, animation: .default) private var savedIngredients: [IngredientDbModel]

    var body: some View {
        VStack {
            List(savedIngredients) { ingredient in
                NavigationLink(destination: IngredientDetailView(ingredient: .constant(ingredient))) {
                    HStack {
                        Text(ingredient.title)
                    }
                }
            }
        }
        .navigationBarItems(trailing: NavigationLink(destination: IngredientListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Ingredienser")
    }
}

#Preview {
    MyIngredientsView()
}

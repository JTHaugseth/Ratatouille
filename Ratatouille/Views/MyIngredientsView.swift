//
//  MyIngredientsView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 28/11/2023.
//

import SwiftUI

struct MyIngredientsView: View {
    @ObservedObject var viewModel = IngredientViewModel()

    var body: some View {
        VStack {
            if viewModel.ingredients.isEmpty {
                Spacer()
                Text("Ingen Ingredienser")
                Spacer()
            } else {
                List(viewModel.ingredients, id: \.idIngredient) { ingredient in
                    Text(ingredient.strIngredient)
                }
            }
        }
        .onAppear(perform: viewModel.loadSavedIngredients)
        .navigationBarItems(trailing: NavigationLink(destination: IngredientListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Ingredienser")
    }
}

#Preview {
    MyIngredientsView()
}

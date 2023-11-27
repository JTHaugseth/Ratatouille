//
//  IngredientListView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI

struct IngredientListView: View {
    @ObservedObject var viewModel = IngredientViewModel()
    
    var body: some View {
        List(viewModel.ingredients, id: \.idIngredient) { ingredient in
            Text(ingredient.strIngredient)
        }
        .onAppear(perform: viewModel.loadIngredients)
        .navigationTitle("Ingredients")
        .navigationBarItems(trailing: Button(action: {
            // Handle add category action
        }) {
            Image(systemName: "plus")
        })
    }
}

#Preview {
    IngredientListView()
}

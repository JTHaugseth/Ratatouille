//
//  IngredientListView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI

struct IngredientListView: View {
    @ObservedObject var viewModel = IngredientViewModel()
    @State private var searchText = ""

    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Søk ingredienser")
            List(viewModel.filteredIngredients(searchText), id: \.idIngredient) { ingredient in
                HStack {
                    Text(ingredient.strIngredient)
                    Spacer()
                    Image(systemName: viewModel.isSelected(ingredient: ingredient) ? "checkmark.square" : "square")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.toggleSelection(ingredient: ingredient)
                }
                .listRowBackground(viewModel.isSelected(ingredient: ingredient) ? Color.green.opacity(0.4) : Color.clear)
            }
        }
        .onAppear(perform: viewModel.loadIngredientsFromAPI)
        .navigationTitle("Ingredienser")
        .navigationBarItems(
            trailing: HStack {
                Button("Velg alle", action: viewModel.toggleAllSelections)
                Button("Importer", action: viewModel.importSelectedIngredients)
            }
        )
    }
}

#Preview {
    IngredientListView()
}

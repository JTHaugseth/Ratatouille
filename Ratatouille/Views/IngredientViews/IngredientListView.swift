//
//  IngredientListView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI
import SwiftData

struct IngredientListView: View {
    @ObservedObject var viewModel = IngredientViewModel()
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
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
                Button("Importer", action: importSelectedIngredients)
            }
        )
    }
    func importSelectedIngredients() {
        for ingredient in viewModel.ingredients {
            if viewModel.selectedIngredients.contains(ingredient.idIngredient) {
                let newIngredient = IngredientDbModel()
                newIngredient.oldID = ingredient.idIngredient
                newIngredient.title = ingredient.strIngredient
                newIngredient.descriptions = ingredient.strDescription ?? ""
                newIngredient.type = ingredient.strType ?? ""
                
                context.insert(newIngredient)
            }
        }
        presentationMode.wrappedValue.dismiss()
        
    }
}

#Preview {
    IngredientListView()
}

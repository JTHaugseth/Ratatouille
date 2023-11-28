//
//  CategoryListView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI

struct CategoryListView: View {
    @ObservedObject var viewModel = CategoryViewModel()
    
    var body: some View {
        List(viewModel.categories, id: \.strCategory) { category in
            HStack {
                Text(category.strCategory)
                Spacer()
                Image(systemName: viewModel.isSelected(category: category) ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.toggleSelection(category: category)
            }
            .listRowBackground(viewModel.isSelected(category: category) ? Color.green.opacity(0.4) : Color.clear)
        }
        .onAppear(perform: viewModel.loadCategoriesFromAPI)
        .navigationTitle("Kategorier")
        .navigationBarItems(
            trailing: HStack {
                Button("Velg alle", action: viewModel.toggleAllSelections)
                Button("Importer", action: viewModel.importSelectedCategories)
            }
        )
    }
}

#Preview {
    CategoryListView()
}

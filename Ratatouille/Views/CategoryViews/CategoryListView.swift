//
//  CategoryListView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI
import SwiftData

struct CategoryListView: View {
    @ObservedObject var viewModel = CategoryViewModel()
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List(viewModel.categories, id: \.idCategory) { category in
            HStack {
                if let url = URL(string: category.strCategoryThumb) {
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
                Button("Importer", action: importSelectedCategories)
            }
        )
    }
    func importSelectedCategories() {
        for category in viewModel.categories {
            if viewModel.selectedCategories.contains(category.strCategory) {
                let newCategory = CategoryDbModel()
                newCategory.oldID = category.idCategory
                newCategory.title = category.strCategory
                newCategory.descriptions = category.strCategoryDescription
                newCategory.thumb = category.strCategoryThumb
                
                context.insert(newCategory)
            }
        }
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    CategoryListView()
}

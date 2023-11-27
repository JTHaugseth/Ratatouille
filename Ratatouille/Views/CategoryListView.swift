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
            Text(category.strCategory)
        }
        .onAppear(perform: viewModel.loadCategoriesFromAPI)
        .navigationTitle("Categories")
        .navigationBarItems(trailing: Button(action: {
            // Handle add category action
        }) {
            Image(systemName: "plus")
        })
    }
}

#Preview {
    CategoryListView()
}

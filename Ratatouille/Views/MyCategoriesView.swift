//
//  MyCategoriesView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 28/11/2023.
//

import SwiftUI

struct MyCategoriesView: View {
    @ObservedObject var viewModel = CategoryViewModel()

    var body: some View {
        VStack {
            if viewModel.categories.isEmpty {
                Spacer()
                Text("Ingen Kategorier")
                Spacer()
            } else {
                List(viewModel.categories, id: \.strCategory) { category in
                    Text(category.strCategory)
                }
            }
        }
        .onAppear(perform: viewModel.loadSavedCategories)
        .navigationBarItems(trailing: NavigationLink(destination: CategoryListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Kategorier")
    }
}

#Preview {
    MyCategoriesView()
}

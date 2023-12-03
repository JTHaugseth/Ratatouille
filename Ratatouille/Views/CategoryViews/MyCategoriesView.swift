//
//  MyCategoriesView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 28/11/2023.
//

import SwiftUI
import SwiftData

struct MyCategoriesView: View {
    @ObservedObject var viewModel = CategoryViewModel()
    
    @Query(filter: #Predicate<CategoryDbModel>{$0.archived == false},
           sort: \CategoryDbModel.title, order: .forward, animation: .default) private var savedCategories: [CategoryDbModel]
    
    var body: some View {
        VStack {
            List(savedCategories) { category in
                NavigationLink(destination: CategoryDetailView(category: .constant(category))) {
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
        }
        .navigationBarItems(trailing: NavigationLink(destination: CategoryListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Kategorier")
    }
}

#Preview {
    MyCategoriesView()
}

//
//  MyAreasView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 28/11/2023.
//

import SwiftUI
import SwiftData

struct MyAreasView: View {
    @ObservedObject var viewModel = AreaViewModel()
    
    @Query(filter: #Predicate<AreaDbModel>{$0.archived == false},
           sort: \AreaDbModel.title, order: .forward, animation: .default) private var savedAreas: [AreaDbModel]

    var body: some View {
        VStack {
            List(savedAreas) { area in
                NavigationLink(destination: AreaDetailView(area: .constant(area))) {
                    HStack {
                        if let flagURL = URL(string: "https://flagsapi.com/\(area.countrycode)/flat/64.png") {
                            AsyncImage(url: flagURL) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                        } else {
                            // Fallback if flag URL is not available
                            Color.gray
                                .frame(width: 50, height: 50)
                        }

                        Text(area.title)
                    }
                }
            }
        }
        .navigationBarItems(trailing: NavigationLink(destination: AreaListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Landområder")
    }
}

#Preview {
    MyAreasView()
}

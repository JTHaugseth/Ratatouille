//
//  AreaListView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI

struct AreaListView: View {
    @ObservedObject var viewModel = AreaViewModel()

    var body: some View {
        List(viewModel.areas, id: \.strArea) { area in
            Text(area.strArea)
        }
        .onAppear(perform: viewModel.loadAreasFromAPI)
        .navigationTitle("Areas")
        .navigationBarItems(trailing: Button(action: {
            // Handle add category action
        }) {
            Image(systemName: "plus")
        })
    }
}

#Preview {
    AreaListView()
}

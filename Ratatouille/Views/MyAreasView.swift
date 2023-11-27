//
//  MyAreasView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 28/11/2023.
//

import SwiftUI

struct MyAreasView: View {
    @ObservedObject var viewModel = AreaViewModel()

    var body: some View {
        VStack {
            if viewModel.areas.isEmpty {
                Spacer()
                Text("Ingen Landområder")
                Spacer()
            } else {
                List(viewModel.areas, id: \.strArea) { area in
                    Text(area.strArea)
                }
            }
        }
        .onAppear(perform: viewModel.loadSavedAreas)
        .navigationBarItems(trailing: NavigationLink(destination: AreaListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Landområder")
    }
}

#Preview {
    MyAreasView()
}

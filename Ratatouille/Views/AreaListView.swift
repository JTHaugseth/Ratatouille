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
            HStack {
                Text(area.strArea)
                Spacer()
                Image(systemName: viewModel.isSelected(area: area) ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.toggleSelection(area: area)
            }
            .listRowBackground(viewModel.isSelected(area: area) ? Color.green.opacity(0.4) : Color.clear)
        }
        .onAppear(perform: viewModel.loadAreasFromAPI)
        .navigationTitle("Land")
        .navigationBarItems(
            trailing: HStack {
                Button("Velg alle", action: viewModel.toggleAllSelections)
                Button("Importer", action: viewModel.importSelectedAreas)
            }
        )
    }
}

#Preview {
    AreaListView()
}

//
//  SettingsView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDarkModeEnabled = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Innstillinger")) {
                    NavigationLink(destination: AreaListView()) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Importer Landområder")
                        }
                    }
                    NavigationLink(destination: CategoryListView()) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Importer Kategorier")
                        }
                    }
                    NavigationLink(destination: IngredientListView()) {
                        HStack {
                            Image(systemName: "leaf")
                            Text("Importer Ingredienser")
                        }
                    }
                }
                
                Section {
                    Toggle(isOn: $isDarkModeEnabled) {
                        HStack {
                            Image(systemName: "moon.fill")
                            Text("Aktiver Mørk-Modus")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: Text("Administrere arkiv")) {
                        HStack {
                            Image(systemName: "archivebox")
                            Text("Administrer Arkiv")
                        }
                    }
                }
            }
            .navigationTitle("Innstillinger")
            .listStyle(GroupedListStyle())
        }
    }
}

#Preview {
    SettingsView()
}

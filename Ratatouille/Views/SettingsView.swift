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
                    NavigationLink(destination: Text("Rediger landområder")) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Redigere landområder")
                        }
                    }
                    NavigationLink(destination: Text("Rediger kategorier")) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Redigere kategorier")
                        }
                    }
                    NavigationLink(destination: Text("Rediger ingredienser")) {
                        HStack {
                            Image(systemName: "leaf")
                            Text("Redigere ingredienser")
                        }
                    }
                }
                
                Section {
                    Toggle(isOn: $isDarkModeEnabled) {
                        HStack {
                            Image(systemName: "moon.fill")
                            Text("Aktiver mørk modus")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: Text("Administrere arkiv")) {
                        HStack {
                            Image(systemName: "archivebox")
                            Text("Administrere arkiv")
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

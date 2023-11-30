//
//  MainView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            NavigationView {
                VStack {
                    Spacer()
                    Image(systemName: "book.closed.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                    Text("Ingen matoppskrifter")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .navigationTitle("RATATOUILLE")
                .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("Mine oppskrifter")
            }
            
            NavigationView {
                SearchView()
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Søk")
            }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Innstillinger")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


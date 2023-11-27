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
                    Text("Ingen matoppskrifter")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .navigationTitle("RATATOUILLE")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image(systemName: "line.horizontal.3")
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Image(systemName: "bell")
                    }
                }
            }
            .tabItem {
                Label("Mine oppskrifter", systemImage: "book.fill")
            }
            
            // Her kan du legge til de andre fanene dine
            Text("Søk")
                .tabItem {
                    Label("Søk", systemImage: "magnifyingglass")
                }
            
            Text("Innstillinger")
                .tabItem {
                    Label("Innstillinger", systemImage: "gear")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


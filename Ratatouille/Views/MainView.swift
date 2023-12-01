//
//  MainView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<MealDbModel>{$0.archived == false},
           sort: \MealDbModel.title, order: .forward, animation: .default) private var savedMeals: [MealDbModel]
    
    var body: some View {
        TabView {
            NavigationView {
                if savedMeals.isEmpty {
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
                } else {
                    List(savedMeals, id: \.id) { meal in
                        NavigationLink(destination: SavedMealDetailView(mealDbModel: meal)) {
                            HStack {
                                if let url = URL(string: meal.thumb) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                }
                                Text(meal.title)
                                
                                Spacer()
                                
                                if meal.favorite {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                archiveMeal(meal)
                            } label: {
                                Label("Archive", systemImage: "archivebox")
                            }
                            .tint(.blue)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                favoriteMeal(meal)
                            } label: {
                                Label("Favorite", systemImage: "star.fill")
                            }
                            .tint(.yellow)
                        }
                    }
                    .navigationBarTitle("Mine oppskrifter")
                }
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
    
    private func archiveMeal(_ meal: MealDbModel) {
        meal.archived = true
        meal.update = Date.now
        try? context.save()
        print("Archiving meal: \(meal.title)")
    }

    private func favoriteMeal(_ meal: MealDbModel) {
        meal.favorite.toggle()
        meal.update = Date.now
        try? context.save()
        print("Favoriting meal: \(meal.title)")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


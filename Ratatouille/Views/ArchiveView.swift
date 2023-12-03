//
//  ArchiveView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 29/11/2023.
//

import SwiftUI
import SwiftData

struct ArchiveView: View {
    @Environment(\.modelContext) private var context
    
    @Query(filter: #Predicate<AreaDbModel>{$0.archived == true},
           sort: \AreaDbModel.title, order: .forward, animation: .default) private var savedAreas: [AreaDbModel]
    
    @Query(filter: #Predicate<CategoryDbModel>{$0.archived == true},
           sort: \CategoryDbModel.title, order: .forward, animation: .default) private var savedCategories: [CategoryDbModel]
    
    @Query(filter: #Predicate<IngredientDbModel>{$0.archived == true},
           sort: \IngredientDbModel.title, order: .forward, animation: .default) private var savedIngredients: [IngredientDbModel]
    
    @Query(filter: #Predicate<MealDbModel>{$0.archived == true},
           sort: \MealDbModel.title, order: .forward, animation: .default) private var savedMeals: [MealDbModel]
    
    var body: some View {
        List {
            if savedAreas.isEmpty {
                Section(header: Text("LANDOMRÅDER")) {
                    Text("Ingen arkiverte landområder")
                }
            } else {
                Section(header: Text("LANDOMRÅDER")) {
                    ForEach(savedAreas) { area in
                        VStack(alignment: .leading) {
                            Text(area.title)
                            Text("Arkivert: \(area.update.formatted(date: .abbreviated, time: .standard))")
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                context.delete(area)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            Button {
                                area.archived = false
                                area.update = Date.now
                                try? context.save()
                            } label: {
                                Label("Unarchive", systemImage: "tray.and.arrow.up.fill")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            
            if savedCategories.isEmpty {
                Section(header: Text("KATEGORIER")) {
                    Text("Ingen arkiverte kategorier")
                }
            } else {
                Section(header: Text("KATEGORIER")) {
                    ForEach(savedCategories, id: \.self) { category in
                        VStack(alignment: .leading) {
                            Text(category.title)
                            Text("Arkivert: \(category.update.formatted(date: .abbreviated, time: .standard))")
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                context.delete(category)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            Button {
                                category.archived = false
                                category.update = Date.now
                                try? context.save()
                            } label: {
                                Label("Unarchive", systemImage: "tray.and.arrow.up.fill")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            
            if savedIngredients.isEmpty {
                Section(header: Text("INGREDIENSER")) {
                    Text("Ingen arkiverte ingredienser")
                }
            } else {
                Section(header: Text("INGREDIENSER")) {
                    ForEach(savedIngredients, id: \.self) { ingredient in
                        VStack(alignment: .leading) {
                            Text(ingredient.title)
                            Text("Arkivert: \(ingredient.update.formatted(date: .abbreviated, time: .standard))")
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                context.delete(ingredient)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            Button {
                                ingredient.archived = false
                                ingredient.update = Date.now
                                try? context.save()
                            } label: {
                                Label("Unarchive", systemImage: "tray.and.arrow.up.fill")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            
            if savedMeals.isEmpty {
                Section(header: Text("OPPSKRIFTER")) {
                    Text("Ingen arkiverte oppskrifter")
                }
            } else {
                Section(header: Text("OPPSKRIFTER")) {
                    ForEach(savedMeals, id: \.self) { meal in
                        VStack(alignment: .leading) {
                            Text(meal.title)
                            Text("Arkivert: \(meal.update.formatted(date: .abbreviated, time: .standard))")
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button(role: .destructive) {
                                context.delete(meal)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            Button {
                                meal.archived = false
                                meal.update = Date.now
                                try? context.save()
                            } label: {
                                Label("Unarchive", systemImage: "tray.and.arrow.up.fill")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            
        }
        .listStyle(GroupedListStyle()) // This should remove the top padding.
        .navigationTitle("Arkiv")
    }
}

#Preview {
    ArchiveView()
}

//
//  IngredientDetailView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 29/11/2023.
//

import SwiftUI
import SwiftData

struct IngredientDetailView: View {
    @Binding var ingredient: IngredientDbModel
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode

    @State private var editedTitle: String = ""
    @State private var editedDescription: String = ""
    @State private var editedType: String = ""

    var body: some View {
        Form {
            TextField("Title", text: $editedTitle)
            TextField("Description", text: $editedDescription)
            TextField("Type", text: $editedType)
        }
        .onAppear {
            editedTitle = ingredient.title
            editedDescription = ingredient.descriptions
            editedType = ingredient.type
        }
        .navigationBarItems(
            trailing: HStack {
                Button("Archive") {
                    archiveCategory(ingredient)
                }
                Button("Save") {
                    updateCategory(ingredient)
                }
            }
        )
    }

    private func updateCategory(_ ingredient: IngredientDbModel) {
        ingredient.title = editedTitle
        ingredient.descriptions = editedDescription
        ingredient.type = editedType
        ingredient.update = Date.now
        
        try? context.save()

        presentationMode.wrappedValue.dismiss()
    }

    private func archiveCategory(_ ingredient: IngredientDbModel) {
        ingredient.archived = true
        ingredient.update = Date.now
        
        try? context.save()

        presentationMode.wrappedValue.dismiss()
    }
}

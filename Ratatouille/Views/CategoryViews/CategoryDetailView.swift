//
//  CategoryDetailView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 29/11/2023.
//

import SwiftUI
import SwiftData

struct CategoryDetailView: View {
    @Binding var category: CategoryDbModel
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode

    @State private var editedTitle: String = ""
    @State private var editedDescription: String = ""
    @State private var editedThumbURL: String = ""

    var body: some View {
        Form {
            TextField("Title", text: $editedTitle)
            TextField("Description", text: $editedDescription)
            TextField("Thumbnail URL", text: $editedThumbURL)
        }
        .onAppear {
            editedTitle = category.title
            editedDescription = category.descriptions
            editedThumbURL = category.thumb
        }
        .navigationBarItems(
            trailing: HStack {
                Button("Archive") {
                    archiveCategory(category)
                }
                Button("Save") {
                    updateCategory(category)
                }
            }
        )
    }

    private func updateCategory(_ category: CategoryDbModel) {
        category.title = editedTitle
        category.descriptions = editedDescription
        category.thumb = editedThumbURL
        category.update = Date.now
        
        try? context.save()

        presentationMode.wrappedValue.dismiss()
    }

    private func archiveCategory(_ category: CategoryDbModel) {
        category.archived = true
        category.update = Date.now
        
        try? context.save()

        presentationMode.wrappedValue.dismiss()
    }
}

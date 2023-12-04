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
            Section {
                VStack(alignment: .leading) {
                    Text("Ingrediens Navn").font(.caption).foregroundColor(.secondary)
                    TextField("Title", text: $editedTitle)
                }
                
                VStack(alignment: .leading) {
                    Text("Innhold").font(.caption).foregroundColor(.secondary)
                    TextField("Description", text: $editedDescription)
                }
                
                VStack(alignment: .leading) {
                    Text("Type").font(.caption).foregroundColor(.secondary)
                    TextField("Type", text: $editedType)
                }
            }
            Section
            {
                Text("Opprettet: \(ingredient.create.formatted(date: .abbreviated, time: .standard))")
                Text("Sist endret: \(ingredient.update.formatted(date: .abbreviated, time: .standard))")
            }
            .foregroundStyle(.secondary)
        }
        .onAppear {
            editedTitle = ingredient.title
            editedDescription = ingredient.descriptions
            editedType = ingredient.type
        }
        .navigationBarItems(
            trailing: HStack {
                Button("Arkiver") {
                    archiveCategory(ingredient)
                }
                Button("Lagre") {
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

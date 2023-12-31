import SwiftUI
import SwiftData

struct SavedMealDetailView: View {
    @State private var isEditMode: Bool = false
    @State private var editableTitle: String
    @State private var editableInstructions: String
    @State private var editableIngredients: String
    var mealDbModel: MealDbModel
    @Environment(\.modelContext) private var context
    
    init(mealDbModel: MealDbModel) {
        self.mealDbModel = mealDbModel
        _editableTitle = State(initialValue: mealDbModel.title)
        _editableInstructions = State(initialValue: mealDbModel.instructions)
        _editableIngredients = State(initialValue: mealDbModel.ingredients)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let url = URL(string: mealDbModel.thumb) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
                
                HStack {
                    if isEditMode {
                        TextEditor(text: $editableTitle)
                            .frame(minHeight: 50)
                            .font(.title)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    } else {
                        Text(editableTitle)
                            .font(.title)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    
                    Spacer()
                    
                    Button(action: { toggleEditMode() }) {
                        Image(systemName: isEditMode ? "checkmark" : "pencil")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                    }
                }
                
                if let area = mealDbModel.area?.title, let category = mealDbModel.category?.title {
                    Text("\(category) - \(area)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                Group {
                    if isEditMode {
                        Text("Ingredienser")
                            .font(.headline)
                        TextEditor(text: $editableIngredients)
                            .frame(minHeight: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        Divider()
                        
                        Text("Instruksjoner")
                            .font(.headline)
                        TextEditor(text: $editableInstructions)
                            .frame(minHeight: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    } else {
                        Text("Ingredienser")
                            .font(.headline)
                        VStack(alignment: .leading) {
                            ForEach(parseIngredientsList(mealDbModel.ingredients), id: \.self) { ingredient in
                                Text("• \(ingredient)")
                            }
                        }
                        
                        Divider()
                        
                        Text("Instruksjoner")
                            .font(.headline)
                        Text(mealDbModel.instructions)
                            .font(.body)
                    }
                }
            }
            .padding()
        }
    }
    
    private func toggleEditMode() {
        if isEditMode {
            saveChanges()
        }
        isEditMode.toggle()
    }
    
    private func saveChanges() {
        mealDbModel.title = editableTitle
        mealDbModel.instructions = editableInstructions
        mealDbModel.ingredients = editableIngredients
        
        try? context.save()
    }
    
    private func parseIngredientsList(_ ingredients: String) -> [String] {
        return ingredients.components(separatedBy: ", ").filter { !$0.isEmpty }
    }
}

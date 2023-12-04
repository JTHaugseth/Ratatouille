import SwiftUI
import SwiftData

struct MyIngredientsView: View {
    @ObservedObject var viewModel = IngredientViewModel()
    
    @Query(filter: #Predicate<IngredientDbModel>{$0.archived == false},
           sort: \IngredientDbModel.title, order: .forward, animation: .default) private var savedIngredients: [IngredientDbModel]
    
    var body: some View {
        VStack {
            if savedIngredients.isEmpty {
                Text("Du har ingen ingredienser enda, trykk + for å importere")
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List(savedIngredients) { ingredient in
                    NavigationLink(destination: IngredientDetailView(ingredient: .constant(ingredient))) {
                        HStack {
                            Text(ingredient.title)
                        }
                    }
                }
            }
        }
        .navigationBarItems(trailing: NavigationLink(destination: IngredientListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Ingredienser")
    }
}

#Preview {
    MyIngredientsView()
}

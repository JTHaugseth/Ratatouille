import SwiftUI
import SwiftData

struct MyCategoriesView: View {
    @ObservedObject var viewModel = CategoryViewModel()
    
    @Query(filter: #Predicate<CategoryDbModel>{$0.archived == false},
           sort: \CategoryDbModel.title, order: .forward, animation: .default) private var savedCategories: [CategoryDbModel]
    
    var body: some View {
        VStack {
            if savedCategories.isEmpty {
                Text("Du har ingen kategorier enda, trykk + for å importere")
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List(savedCategories) { category in
                    NavigationLink(destination: CategoryDetailView(category: .constant(category))) {
                        HStack {
                            if let url = URL(string: category.thumb) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                            } else {
                                Color.gray
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                            }
                            
                            Text(category.title)
                        }
                    }
                }
            }
        }
        .navigationBarItems(trailing: NavigationLink(destination: CategoryListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Kategorier")
    }
}

#Preview {
    MyCategoriesView()
}

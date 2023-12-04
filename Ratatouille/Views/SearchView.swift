import SwiftUI
import SwiftData

struct SearchView: View {
    
    @Query(filter: #Predicate<AreaDbModel>{$0.archived == false}, sort: \AreaDbModel.title, order: .forward, animation: .default) private var savedAreas: [AreaDbModel]
    @Query(filter: #Predicate<CategoryDbModel>{$0.archived == false}, sort: \CategoryDbModel.title, order: .forward, animation: .default) private var savedCategories: [CategoryDbModel]
    @Query(filter: #Predicate<IngredientDbModel>{$0.archived == false}, sort: \IngredientDbModel.title, order: .forward, animation: .default) private var savedIngredients: [IngredientDbModel]
    
    @State private var selectedButtonType: SelectedButtonType? = nil
    @State private var selectedItemTitle: String = ""
    @State private var showDetails = false
    @State private var meals: [Meal] = []
    @State private var searchQuery: String = ""
    
    private let apiService = ApiService()
    
    var body: some View {
        VStack {
            HStack {
                if !showDetails {
                    switch selectedButtonType {
                    case .area:
                        areaList()
                    case .category:
                        categoryList()
                    case .ingredient:
                        ingredientList()
                    case .search:
                        searchField()
                    default:
                        Text("Søk etter Oppskrifter")
                    }
                }
                
                if showDetails {
                    mealListView()
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.default, value: showDetails)
            
            bottomBar()
        }
        .animation(.default, value: selectedButtonType)
    }
    
    private func areaList() -> some View {
        List(savedAreas, id: \.self) { area in
            Button(action: { selectItem(area.title) }) {
                HStack {
                    if let flagURL = URL(string: "https://flagsapi.com/\(area.countrycode)/flat/64.png") {
                        AsyncImage(url: flagURL) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 50, height: 50)
                    } else {
                        Color.gray
                            .frame(width: 50, height: 50)
                    }
                    
                    Text(area.title)
                }
            }
        }
        .transition(.move(edge: .leading))
    }
    
    private func categoryList() -> some View {
        List(savedCategories, id: \.self) { category in
            Button(action: { selectItem(category.title) }) {
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
        .transition(.move(edge: .leading))
    }
    
    private func ingredientList() -> some View {
        List(savedIngredients, id: \.self) { ingredient in
            Button(action: { selectItem(ingredient.title) }) {
                Text(ingredient.title)
            }
        }
        .transition(.move(edge: .leading))
    }
    
    private func searchField() -> some View {
        HStack {
            TextField("Søk etter oppskrifter...", text: $searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Søk") {
                withAnimation {
                    showDetails = true
                    fetchMealsForSearchQuery(searchQuery)
                }
            }
            .padding(EdgeInsets(top: 6, leading: 15, bottom: 6, trailing: 15))
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .font(.system(size: 20))
        }
    }
    
    private func bottomBar() -> some View {
        HStack {
            Spacer()
            
            Button(action: {
                selectedButtonType = .area
                showDetails = false
            }) {
                buttonView(systemName: "globe", color: .blue)
            }
            
            Spacer()
            
            Button(action: {
                selectedButtonType = .category
                showDetails = false
            }) {
                buttonView(systemName: "list.bullet", color: .green)
            }
            
            Spacer()
            
            Button(action: {
                selectedButtonType = .ingredient
                showDetails = false
            }) {
                buttonView(systemName: "leaf", color: .orange)
            }
            
            Spacer()
            
            Button(action: {
                selectedButtonType = .search
                showDetails = false
            }) {
                buttonView(systemName: "magnifyingglass", color: .red)
            }
            
            Spacer()
        }
        .padding(.bottom)
    }
    
    private func selectItem(_ title: String) {
        selectedItemTitle = title
        withAnimation {
            showDetails = true
        }
        fetchMealsForSelectedItem(title)
    }
    
    private func fetchMealsForSelectedItem(_ title: String) {
        switch selectedButtonType {
        case .area:
            apiService.fetchMealsByArea(area: title) { result in
                handleFetchResult(result)
            }
        case .category:
            apiService.fetchMealsByCategory(category: title) { result in
                handleFetchResult(result)
            }
        case .ingredient:
            apiService.fetchMealsByIngredient(ingredient: title) { result in
                handleFetchResult(result)
            }
        default:
            break
        }
    }
    
    private func fetchMealsForSearchQuery(_ query: String) {
        apiService.fetchMealsBySearch(searchString: query) { result in
            handleFetchResult(result)
        }
    }
    
    private func handleFetchResult(_ result: Result<[Meal], Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let fetchedMeals):
                meals = fetchedMeals
            case .failure(let error):
                print("Error fetching meals: \(error)")
            }
        }
    }
    
    private func mealListView() -> some View {
        VStack {
            Text("Oppskrifter basert på \(selectedItemTitle)")
            List(meals, id: \.idMeal) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.idMeal)) {
                    HStack {
                        if let url = URL(string: meal.strMealThumb) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        } else {
                            Color.gray
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                        }
                        Text(meal.strMeal)
                    }
                }
            }
            Button("Tilbake") {
                withAnimation {
                    showDetails = false
                }
            }
        }
    }
    
    private func buttonView(systemName: String, color: Color) -> some View {
        Image(systemName: systemName)
            .foregroundColor(.white)
            .padding()
            .background(color)
            .clipShape(Circle())
            .shadow(radius: 5)
    }
    
    enum SelectedButtonType {
        case area, category, ingredient, search
    }
}

#Preview {
    SearchView()
}





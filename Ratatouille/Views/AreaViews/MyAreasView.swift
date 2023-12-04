import SwiftUI
import SwiftData

struct MyAreasView: View {
    @ObservedObject var viewModel = AreaViewModel()
    
    @Query(filter: #Predicate<AreaDbModel>{$0.archived == false},
           sort: \AreaDbModel.title, order: .forward, animation: .default) private var savedAreas: [AreaDbModel]
    
    var body: some View {
        VStack {
            if savedAreas.isEmpty {
                Text("Du har ingen landområder enda, trykk + for å importere")
                    .multilineTextAlignment(.center)
                    .padding()
            } else {
                List(savedAreas) { area in
                    NavigationLink(destination: AreaDetailView(area: .constant(area))) {
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
            }
        }
        .navigationBarItems(trailing: NavigationLink(destination: AreaListView()) {
            Image(systemName: "plus")
        })
        .navigationTitle("Mine Landområder")
    }
}

#Preview {
    MyAreasView()
}

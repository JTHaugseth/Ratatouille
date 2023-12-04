import SwiftUI
import SwiftData

struct AreaListView: View {
    @ObservedObject var viewModel = AreaViewModel()
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        List(viewModel.areas, id: \.strArea) { area in
            HStack {
                if let url = viewModel.flagURL(for: area) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 50, height: 50)
                    
                } else {
                    Color.gray
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                }
                
                Text(area.strArea)
                Spacer()
                Image(systemName: viewModel.isSelected(area: area) ? "checkmark.square" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .contentShape(Rectangle())
            .onTapGesture {
                viewModel.toggleSelection(area: area)
            }
            .listRowBackground(viewModel.isSelected(area: area) ? Color.green.opacity(0.4) : Color.clear)
        }
        .onAppear(perform: viewModel.loadAreasFromAPI)
        .navigationTitle("Land")
        .navigationBarItems(
            trailing: HStack {
                Button("Velg alle", action: viewModel.toggleAllSelections)
                Button("Importer", action: importSelectedAreas)
            }
        )
    }
    
    func importSelectedAreas() {
        for areaName in viewModel.selectedAreas {
            let countryCode = viewModel.countryNameToCode[areaName] ?? ""
            let newArea = AreaDbModel()
            newArea.title = areaName
            newArea.countrycode = countryCode
            
            context.insert(newArea)
        }
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AreaListView()
}

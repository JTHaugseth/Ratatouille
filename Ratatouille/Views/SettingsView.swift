import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var darkModeManager: DarkModeManager
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Innstillinger")) {
                    NavigationLink(destination: MyAreasView()) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Importer Landområder")
                        }
                    }
                    NavigationLink(destination: MyCategoriesView()) {
                        HStack {
                            Image(systemName: "list.bullet")
                            Text("Importer Kategorier")
                        }
                    }
                    NavigationLink(destination: MyIngredientsView()) {
                        HStack {
                            Image(systemName: "leaf")
                            Text("Importer Ingredienser")
                        }
                    }
                }
                
                Section {
                    Toggle(isOn: $darkModeManager.isDarkModeEnabled) {
                        HStack {
                            Image(systemName: "moon.fill")
                            Text("Aktiver Mørk-Modus")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: ArchiveView()) {
                        HStack {
                            Image(systemName: "archivebox")
                            Text("Administrer Arkiv")
                        }
                    }
                }
            }
            .navigationTitle("Innstillinger")
            .listStyle(GroupedListStyle())
        }
    }
}

#Preview {
    SettingsView()
}

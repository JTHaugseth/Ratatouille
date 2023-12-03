//
//  AreaDetailView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 29/11/2023.
//

import SwiftUI
import SwiftData

struct AreaDetailView: View {
    @Binding var area: AreaDbModel
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editedTitle: String = ""
    @State private var editedCountryCode: String = ""
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("Land Navn").font(.caption).foregroundColor(.secondary)
                    TextField("Title", text: $editedTitle)
                }
                
                VStack(alignment: .leading) {
                    Text("Land Kode").font(.caption).foregroundColor(.secondary)
                    TextField("Country Code", text: $editedCountryCode)
                }
            }
            Section
            {
                Text("Opprettet: \(area.create.formatted(date: .abbreviated, time: .standard))")
                Text("Sist endret: \(area.update.formatted(date: .abbreviated, time: .standard))")
            }
            .foregroundStyle(.secondary)
        }
        .onAppear {
            editedTitle = area.title
            editedCountryCode = area.countrycode
        }
        .navigationTitle(area.title)
        .navigationBarItems(
            trailing: HStack {
                Button("Archive") {
                    archiveArea(area)
                }
                Button("Save") {
                    updateArea(area)
                }
            }
        )
    }
    
    private func updateArea(_ area: AreaDbModel) {
        area.title = editedTitle
        area.countrycode = editedCountryCode
        area.update = Date.now
        
        try? context.save()
        
        presentationMode.wrappedValue.dismiss()
    }
    
    private func archiveArea(_ area: AreaDbModel) {
        area.archived = true
        area.update = Date.now
        
        try? context.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}


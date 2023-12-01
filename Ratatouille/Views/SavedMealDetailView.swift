//
//  SavedMealDetailView.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 01/12/2023.
//

import SwiftUI

struct SavedMealDetailView: View {
    var mealDbModel: MealDbModel

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
                    Text(mealDbModel.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Spacer()

                    Button(action: { editMealRecipe() }) {
                        Image(systemName: "pencil")
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

                Text("Ingredients")
                    .font(.headline)
                VStack(alignment: .leading) {
                    ForEach(parseIngredientsList(mealDbModel.ingredients), id: \.self) { ingredient in
                        Text("• \(ingredient)")
                    }
                }

                Divider()

                Text("Instructions")
                    .font(.headline)
                Text(mealDbModel.instructions)
                    .font(.body)
            }
            .padding()
        }
    }

    private func parseIngredientsList(_ ingredients: String) -> [String] {
        return ingredients.components(separatedBy: ", ").filter { !$0.isEmpty }
    }

    private func editMealRecipe() {
        // Implement the edit logic here
        print("Editing meal: \(mealDbModel.title)")
    }
}

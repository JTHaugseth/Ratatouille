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
        // Display saved meal details here
        Text(mealDbModel.title)
    }
}

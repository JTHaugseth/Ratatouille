//
//  Ingredient.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 27/11/2023.
//

import Foundation

struct Ingredient: Decodable {
    let idIngredient: String
    let strIngredient: String
    let strDescription: String?
    let strType: String?
}

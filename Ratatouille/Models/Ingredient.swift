import Foundation

struct Ingredient: Decodable {
    let idIngredient: String
    let strIngredient: String
    let strDescription: String?
    let strType: String?
}

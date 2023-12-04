import Foundation

struct Category: Decodable, Identifiable {
    var id: String { idCategory }
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

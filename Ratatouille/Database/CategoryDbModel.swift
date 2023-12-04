import Foundation
import SwiftData

@Model final class CategoryDbModel
{
    @Attribute(.unique) let id: UUID
    var oldID: String
    var title: String
    var descriptions: String
    var thumb: String
    var favorite: Bool
    var archived: Bool
    let create: Date
    var update: Date
    
    @Relationship(deleteRule: .nullify, inverse: \MealDbModel.category)
    var meals: [MealDbModel]?
    
    init()
    {
        id = UUID()
        oldID = ""
        title = ""
        descriptions = ""
        thumb = ""
        favorite = false
        archived = false
        create = Date.now
        update = Date.now
    }
}

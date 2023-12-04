import Foundation
import SwiftData

@Model final class MealDbModel
{
    @Attribute(.unique) let id: UUID    
    var oldID: String
    var title: String
    var instructions: String
    var ingredients: String
    var area: AreaDbModel?
    var category: CategoryDbModel?
    var thumb: String
    var youtube: String
    var favorite: Bool
    var archived: Bool
    let create: Date
    var update: Date
    
    init()
    {
        id = UUID()
        oldID = ""
        title = ""
        instructions = ""
        ingredients = ""
        thumb = ""
        youtube = ""
        favorite = false
        archived = false
        create = Date.now
        update = Date.now
    }
}

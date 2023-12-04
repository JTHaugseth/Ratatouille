import Foundation
import SwiftData

@Model final class IngredientDbModel
{
    @Attribute(.unique) let id: UUID    
    var oldID: String
    var title: String
    var descriptions: String
    var type: String
    var favorite: Bool
    var archived: Bool
    let create: Date
    var update: Date
    
    init()
    {
        id = UUID()
        oldID = ""
        title = ""
        descriptions = ""
        type = ""
        favorite = false
        archived = false
        create = Date.now
        update = Date.now
    }
}

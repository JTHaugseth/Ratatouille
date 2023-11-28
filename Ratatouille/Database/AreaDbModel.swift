//
//  AreaDbModel.swift
//  Ratatouille
//
//  Created by Julian Haugseth on 28/11/2023.
//

import Foundation
import SwiftData

@Model final class AreaDbModel
{
  @Attribute(.unique) let id: UUID
  var title: String
  var countrycode: String
  var favorite: Bool
  var archived: Bool
  let create: Date
  var update: Date
  
  @Relationship(deleteRule: .nullify, inverse: \MealDbModel.area)
  var meals: [MealDbModel]?
                                      
  init()
  {
    id = UUID()
    title = ""
    countrycode = ""
    favorite = false
    archived = false
    create = Date.now
    update = Date.now
  }
}

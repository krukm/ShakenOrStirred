import Foundation

class IngredientObject: Codable {
    var idIngredient: String
    var strIngredient: String
    var strDescription: String
    var strType: String
    var strAlcohol: String?
    var strABV: String?
}

class Ingredients: Codable {
    var ingredients: [IngredientObject?]
}

import Foundation

class IngredientObject: Codable, Identifiable {
    var id: String
    var strIngredient: String?
    var strDescription: String?
    var strType: String?
    var strAlcohol: String?
    var strABV: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
    }
}

class Ingredients: Codable {
    var ingredients: [IngredientObject]
}

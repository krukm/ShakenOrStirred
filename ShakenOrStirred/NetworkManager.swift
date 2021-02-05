import Foundation

class NetworkManager {
        
    func getDrinkJSON(searchString: String = "", searchType: Int = 0, id: String = "", completion: @escaping (Drinks?, Error?) -> ()) {
        var baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/"
        let searchValue = searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        
        switch searchType {
            case SearchType.name.asInt():
                baseUrl += "search.php?s=\(searchValue)"
            case SearchType.ingredient.asInt():
                baseUrl += "filter.php?i=\(searchValue)"
            case SearchType.id.asInt():
                baseUrl += "lookup.php?i=\(id)"
            default:
                return
        }
        
        if let url = URL(string: baseUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let drinkResult = try decoder.decode(Drinks?.self, from: data)
                        completion(drinkResult, nil)
                    } catch {
                        completion(nil, error)
                        print("error: \(error)")
                    }
                }
            }.resume()
        }
    }
}

import Foundation

class NetworkManager {
    
    func getDrinkJSON(drinkName: String, completion: @escaping (Drinks) -> ()) {
        let name = drinkName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(name)"
                
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let drinkResult = try decoder.decode(Drinks.self, from: data)
                        completion(drinkResult)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
}

import Combine
import SwiftUI

enum NetworkError: Error {
    case badRequest
    case dataError
}

final class ViewModel: ObservableObject {
    @Published var drinks: Drinks = Drinks(drinks: [Drink]())
    @ObservedObject var searchString = SearchString()
    private var anyCancellable: AnyCancellable?
    
    init() { }
    
    func fetchDrinksListByName() {
        let string = searchString.string
        let formatString = string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(formatString)"
        guard let url = URL(string: urlString) else { return }
        
        anyCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: Drinks.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(".sink() received the completion", String(describing: completion))
                switch completion {
                case .finished:
                    break
                case .failure(let anError):
                    print("received error: ", anError)
                }
            }, receiveValue: { drinks in
                print(".sink() received \(drinks)")
                self.drinks = drinks
            })
    }
    
}

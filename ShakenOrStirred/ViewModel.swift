import Combine
import SwiftUI

enum NetworkError: Error {
    case decodingFailed(DecodingError)
    case failure(Error)
    case requestError(URLError)
}

final class ViewModel: ObservableObject {
    @Published var searchString: String = ""
    @Published var fetchError: Bool = false
    @Published var showResultList: Bool = false
    @Published var drinks: Drinks = Drinks(drinks: [Drink]())
    
    var subscriptions: Set<AnyCancellable> = []
    
    init() { }
    
    func fetchDrinksListByName() -> AnyPublisher<Drinks, Error> {
        let string = searchString
        let formatString = string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(formatString)"
        let url = URL(string: urlString)!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Drinks.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func postResults() {
        fetchDrinksListByName()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("sink error: \(error)")
                    self.fetchError = true
                    self.showResultList = false
                    print(self.fetchError)
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] drinks in
                self?.drinks.drinks.removeAll()
                self?.drinks.drinks.append(contentsOf: drinks.drinks)
                self?.showResultList = true
            })
            .store(in: &subscriptions)
    }
}

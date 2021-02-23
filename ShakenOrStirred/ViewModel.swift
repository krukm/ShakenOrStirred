import Combine
import SwiftUI

enum NetworkError: Error {
    case decodingFailed(DecodingError)
    case failure(Error)
    case incorrectStatusCode(Int)
    case nonHTTPResponse
    case requestError(URLError)
}

final class ViewModel: ObservableObject {
    @Published var searchString: String = ""
    @Published var fetchError: Bool = false
    @Published var drinks: Drinks = Drinks(drinks: [Drink]())
    @Published var isLoading: Bool = false
    
    var subscriptions: Set<AnyCancellable> = []
    let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/"
    let decoder = JSONDecoder()
        
    init() { }
    
    func fetchDrinksListByName() -> AnyPublisher<Drinks, Error> {
        isLoading = true
        let string = searchString
        let formatString = string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        let url = "\(baseUrl)search.php?s=\(formatString)"
        
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap{ (data, response) in
                try self.checkNetworkError(response: response)
                return data
            }
            .decode(type: Drinks.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func subscribeByName() {
        fetchDrinksListByName()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("error: ", error)
                    self.fetchError = true
                case .finished:
                    self.isLoading = false
                    break
                }
            }, receiveValue: { [weak self] drinks in
                self?.drinks.drinks.removeAll()
                self?.drinks = drinks
            })
            .store(in: &subscriptions)
    }
    
    func fetchDrinksByIngredient() {
        isLoading = true
        let drinksByIngredientUrl = "\(baseUrl)filter.php?i=\(searchString)"
        
        URLSession.shared.dataTaskPublisher(for: URL(string: drinksByIngredientUrl)!)
            .map { $0.data }
            .decode(type: Drinks.self, decoder: decoder)
            .tryMap { drinks -> [String] in
                var ids: [String] = []
                for drink in drinks.drinks {
                    ids.append(drink.id)
                }
                return ids
            }
            .flatMap() { ids in
                return self.fetchDrinksBy(ids: ids)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("error: ", error)
                case .finished:
                    break
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }
    
    func fetchDrinksBy(ids: [String]) -> Publishers.Sequence<[Drink], Error> {

        var idCollection: [URL] = []
        var drinkList: [Drink] = []
        
        for id in ids {
            let drinksByIdUrl = "\(baseUrl)lookup.php?i=\(id)"
            if let url = URL(string: drinksByIdUrl) {
                idCollection.append(url)
            }
        }
        
        let collection = idCollection
            .compactMap { value in
                URLSession.shared.dataTaskPublisher(for: value)
                    .tryMap { data, response -> Data in
                        return data
                    }
                    .decode(type: Drinks.self, decoder: JSONDecoder())
                    .catch { _ in
                        Just(Drinks(drinks: [Drink]()))
                    }
                    .eraseToAnyPublisher()
            }
        
        collection.serialize().publisher
            .flatMap() { $0 }
            .collect()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("error: ", error)
                case .finished:
                    self.isLoading = false
                    break
                }
            }, receiveValue: { response in
                for drinks in response {
                    for drink in drinks.drinks {
                        drinkList.append(drink)
                        self.drinks.drinks = drinkList
                    }
                }
            })
            .store(in: &subscriptions)
        
        return drinkList.publisher
            .setFailureType(to: Error.self)
    }
    
    func fetchRandomDrink() {
        isLoading = true
        let url = "\(baseUrl)random.php"
        
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap{ (data, response) in
                try self.checkNetworkError(response: response)
                return data
            }
            .decode(type: Drinks.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("error: ", error)
                    self.fetchError = true
                case .finished:
                    self.isLoading = false
                    break
                }
            }, receiveValue: { result in
                self.drinks.drinks.removeAll()
                self.drinks.drinks = result.drinks
            })
            .store(in: &subscriptions)
    }
    
    func checkNetworkError(response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTPResponse
        }
        let statusCode = httpResponse.statusCode
        guard (200..<300).contains(statusCode) else {
            throw NetworkError.incorrectStatusCode(statusCode)
        }
    }
}

extension Collection where Element: Publisher {
    func serialize() -> AnyPublisher<Element.Output, Element.Failure>? {
        guard let start = self.first else { return nil }
        return self.dropFirst().reduce(start.eraseToAnyPublisher()) {
            return $0.append($1).eraseToAnyPublisher()
        }
    }
}

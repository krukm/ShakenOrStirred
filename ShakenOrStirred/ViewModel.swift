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
    
    var subscriptions: Set<AnyCancellable> = []
    let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/"
    let decoder = JSONDecoder()
        
    init() { }
    
    func fetchDrinksListByName() -> AnyPublisher<Drinks, Error> {
        let string = searchString
        let formatString = string.lowercased().trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "%20")
        let url = "\(baseUrl)search.php?s=\(formatString)"
        
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap{ (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.nonHTTPResponse }
                let statusCode = httpResponse.statusCode
                guard (200..<300).contains(statusCode) else { throw NetworkError.incorrectStatusCode(statusCode) }
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
                    print("sink by name error: \(error)")
                    self.fetchError = true
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] drinks in
                print("sink by name: \(drinks)")
                self?.drinks.drinks.removeAll()
                self?.drinks = drinks
            })
            .store(in: &subscriptions)
    }
    
    func fetchDrinksByIngredient() {
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
            .map { ids in
                return self.fetchDrinksBy(ids: ids)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion:  { completion in
                print("completion 1: \(completion)")
            }, receiveValue: { drinks in
                print("drinks 1: \(drinks.sequence)")
            })
            .store(in: &subscriptions)
    }
    
    func fetchDrinksBy(ids: [String]) -> Publishers.Sequence<[Drink], Error> {
        var drinkList: [Drink] = []
        var drinksIds: [String] = []
        
        for id in ids {
            let drinksByIdUrl = "\(baseUrl)lookup.php?i=\(id)"
            drinksIds.append(drinksByIdUrl)
            print("ids")
        }

        for url in drinksIds {
            URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
                .map { $0.data }
                .decode(type: Drinks.self, decoder: self.decoder)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
                .sink(receiveCompletion: { completion in
                    print("completion 2: \(completion)")
                }, receiveValue: { drinks in
                    drinkList.append(drinks.drinks.first!)
                    print("drink received1")
                })
                .store(in: &self.subscriptions)
            print("drink received2")
        }
        print("drinkList: \(drinkList)")
        
        return drinkList.publisher
            .setFailureType(to: Error.self)
    }
    
    func fetchRandomDrink() {
        let url = "\(baseUrl)random.php"
        
        return URLSession.shared.dataTaskPublisher(for: URL(string: url)!)
            .tryMap{ (data, response) in
                guard let httpResponse = response as? HTTPURLResponse else { throw NetworkError.nonHTTPResponse }
                let statusCode = httpResponse.statusCode
                guard (200..<300).contains(statusCode) else { throw NetworkError.incorrectStatusCode(statusCode) }
                return data
            }
            .decode(type: Drinks.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("sink random drink error: \(error)")
                    self.fetchError = true
                case .finished:
                    break
                }
            }, receiveValue: { result in
                print(result)
                self.drinks.drinks.removeAll()
                self.drinks.drinks = result.drinks
            })
            .store(in: &subscriptions)
    }
}

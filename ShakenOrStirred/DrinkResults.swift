import Foundation

class DrinkResults: ObservableObject {
    @Published var drinkResults: [Drink] = []
    @Published var drinkIdResults: [Drink] = []
}

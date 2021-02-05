import Foundation
import SwiftUI

struct DrinkListView: View {
    @Binding var showResultView: Bool
    @ObservedObject var drinkResultArray: DrinkResults
    @State var showListView: Bool = false
    
    let networkManager = NetworkManager()
    
    var body: some View {
        List(drinkResultArray.drinkResults.indexed(), id: \.1.self) { drink in
            NavigationLink(destination: ResultView(drinkResultsArray: drinkResultArray, drinkNumber: drink.index)) {
                Text("\(drink.element.strDrink)")
            }
        }
    }
}

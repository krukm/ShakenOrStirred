import SwiftUI

struct ContentView: View {
    @ObservedObject var drinkResultsArray: DrinkResults
    @ObservedObject var errorView: ErrorView
    @State var showResultList: Bool = false
    @State var drinkNumer: Int = 0
    
    var body: some View {
        HomeView(showResultList: $showResultList, drinkResultArray: drinkResultsArray, errorView: errorView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(drinkResultsArray: DrinkResults(), errorView: ErrorView())
    }
}

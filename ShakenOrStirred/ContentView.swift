import SwiftUI

struct ContentView: View {
    @ObservedObject var drinkResultsArray: DrinkResults
    @ObservedObject var errorView: ErrorView
    @State var showResult: Bool = false
    
    var body: some View {
        HomeView(showResult: $showResult, drinkResultArray: drinkResultsArray, errorView: errorView)
            .background(NavigationLink("", destination: ResultView(drinkResultsArray: drinkResultsArray), isActive: $showResult))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(drinkResultsArray: DrinkResults(), errorView: ErrorView())
    }
}

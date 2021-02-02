import SwiftUI

struct ContentView: View {
    @ObservedObject var drinkResultsArray: DrinkResults
    @ObservedObject var errorView: ErrorView
    @State var showResult: Bool = false
    
    var body: some View {
        NavigationView {
            SearchView(showResult: $showResult, drinkResultArray: drinkResultsArray, errorView: errorView)
                .background(NavigationLink("", destination: ResultView(drinkResultsArray: drinkResultsArray),
                                isActive: $showResult))
        }.accentColor(Colors.zeus)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(drinkResultsArray: DrinkResults(), errorView: ErrorView())
    }
}

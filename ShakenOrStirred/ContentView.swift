import SwiftUI

struct ContentView: View {
    @State var showResult: Bool = false
    @ObservedObject var drinkResultsArray: DrinkResults
    
    var body: some View {
        NavigationView {
            SearchView(showResult: $showResult, drinkResultArray: drinkResultsArray)
                .background(NavigationLink("", destination: ResultView(drinkResultsArray: drinkResultsArray),
                                isActive: $showResult))
        }.accentColor(Colors.zeus)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(drinkResultsArray: DrinkResults())
    }
}

import SwiftUI

struct ContentView: View {
    @State var showResult: Bool = false
    @EnvironmentObject var drinkResultsArray: DrinkResults
    
    var body: some View {
        NavigationView {
            SearchView(showResult: $showResult)
                .background(NavigationLink("", destination: ResultView(),
                                isActive: $showResult))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var errorView: ErrorView
    @State var showResultList: Bool = false
    
    var body: some View {
        HomeView(showResultList: $showResultList, errorView: errorView, viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(), errorView: ErrorView())
    }
}

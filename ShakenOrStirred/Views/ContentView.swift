import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State var showResultList: Bool = false
    
    var body: some View {
        HomeView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}

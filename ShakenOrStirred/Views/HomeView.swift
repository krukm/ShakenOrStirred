import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: ViewModel
    @State var searchType: Int = SearchType.name.asInt()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    Image("search_view_bg")
                        .resizable()
                        .clipped()
                        .overlay(TintOverlay().opacity(0.65))
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 25) {
                        Spacer(minLength: 50)
                        
                        Text("Let's have a Drink!")
                            .font(Font.system(size: 45))
                            .fontWeight(.thin)
                            .foregroundColor(Colors.wafer)
                            .padding(.all, 10.0)
                            .scaledToFill()
                        
                        Spacer()
                        
                        NavigationLink(destination: DrinkListView(viewModel: viewModel, searchType: searchType), isActive: $viewModel.showResultList) {
                                SearchBar(viewModel: viewModel, oncommit: {
                                    viewModel.postResults()
                                })
                        }
                        RadioButtonGroups { selected in
                            self.searchType = selected
                        }
                        
                        if viewModel.fetchError {
                            Text("Could not find anything matching \(viewModel.searchString)")
                                .padding(10)
                                .background(Color.white)
                                .foregroundColor(Color.red)
                                .cornerRadius(8)
                                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 0.5)))
                        }
                        
                        Spacer(minLength: 300)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Colors.zeus)
    }
}

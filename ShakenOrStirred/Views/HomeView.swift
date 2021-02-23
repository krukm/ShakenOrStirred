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
                        
                        Text("Let's have a Drink!")
                            .font(Font.system(size: 45))
                            .fontWeight(.thin)
                            .foregroundColor(Colors.wafer)
                            .padding(.all, 10.0)
                            .scaledToFill()
                        
                        Spacer()
                        
                        SearchBar(viewModel: viewModel, oncommit: {
                            if searchType == SearchType.ingredient.asInt() {
                                viewModel.fetchDrinksByIngredient()
                            } else if searchType == SearchType.name.asInt() {
                                viewModel.subscribeByName()
                            }
                        })
                        .background(NavigationLink("", destination: ResultListView(viewModel: viewModel)))
                            
                        RadioButtonGroups { selected in
                            self.searchType = selected
                        }
                        
                        Button(action: {
                            viewModel.fetchRandomDrink()
                            viewModel.fetchError = false
                        }) {
                            Text("Try random?")
                                .foregroundColor(Colors.saddle)
                                .padding(10)
                                .padding(.horizontal, 50)
                                .background(Colors.arrowTown)
                                .cornerRadius(5)
                        }

                        
                        if viewModel.fetchError {
                            Text("Oh noes!! \(viewModel.searchString) wasn't found :(")
                                .padding(10)
                                .background(Color.white)
                                .foregroundColor(Color.red)
                                .cornerRadius(8)
                                .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut(duration: 0.5)))
                        }
                        
                        if viewModel.isLoading {
                            VStack {
                                Spacer()
                                ProgressView("Loading...")
                                    .scaleEffect(2.0, anchor: .center)
                                    .progressViewStyle(CircularProgressViewStyle(tint: Colors.wafer))
                                    .foregroundColor(Colors.wafer)
                                Spacer(minLength: 300)
                            }
                        } else {
                            ResultListView(viewModel: viewModel)
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Colors.zeus)
    }
}

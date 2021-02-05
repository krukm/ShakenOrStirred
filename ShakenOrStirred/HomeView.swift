import SwiftUI

struct HomeView: View {
    @Binding var showResultList: Bool
    @ObservedObject var drinkResultArray: DrinkResults
    @ObservedObject var errorView: ErrorView
    @State private var searchText = ""
    @State private var searchType: Int = SearchType.name.asInt()
    @State var showResultView: Bool = false
    
    let networkManager = NetworkManager()
    
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
                        
                        SearchBar(searchText: $searchText, errorView: errorView, oncommit: {
                            
                            networkManager.getDrinkJSON(searchString: searchText, searchType: searchType, completion: { result, error in
                                if error != nil {
                                    DispatchQueue.main.async {
                                        errorView.showErrorView = true
                                        showResultList = false
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    if let drinks = result?.drinks {
                                        drinkResultArray.drinkResults.removeAll()
                                        drinkResultArray.drinkResults.append(contentsOf: drinks)
                                        showResultList = true
                                    }
                                }
                            })
                        })
                        .background(NavigationLink("", destination: DrinkListView(showResultView: $showResultView, drinkResultArray: drinkResultArray, showListView: showResultList), isActive: $showResultList))
                        
                        RadioButtonGroups { selected in
                            self.searchType = selected
                        }
                        
                        if errorView.showErrorView {
                            Text("Could not find anything matching \(searchText)")
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
        }.accentColor(Colors.zeus)
    }
}

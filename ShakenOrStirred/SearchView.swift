import SwiftUI

struct SearchView: View {
    @Binding var showResult: Bool
    @ObservedObject var drinkResultArray: DrinkResults
    @ObservedObject var errorView: ErrorView
    @State private var searchText = ""
    
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
                            networkManager.getDrinkJSON(drinkName: searchText, completion: { result, error in                                
                                if error != nil {
                                    DispatchQueue.main.async {
                                        errorView.showErrorView = true
                                        showResult = false
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    if let drink = result?.drinks[0] {
                                        drinkResultArray.drinkResults.removeAll()
                                        drinkResultArray.drinkResults.append(drink)
                                        showResult = true
                                        print(drink)
                                    }
                                }
                            })
                        })
                        
                        if errorView.showErrorView {
                            Text("Could not find a drink named \(searchText)")
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
    }
}

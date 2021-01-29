import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @Binding var showResult: Bool
    @ObservedObject var drinkResultArray: DrinkResults
    
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
                        
                        Text("I need a Drink!")
                            .font(Font.system(size: 65))
                            .fontWeight(.thin)
                            .foregroundColor(Colors.wafer)
                            .padding(.all, 10.0)
                        
                        Spacer()
                        
                        SearchBar(text: $searchText, oncommit: {
                            networkManager.getDrinkJSON(drinkName: searchText, completion: { result in
                                DispatchQueue.main.async {
                                    drinkResultArray.drinkResults.removeAll()
                                    drinkResultArray.drinkResults.append(result.drinks[0])
                                    print(drinkResultArray.drinkResults[0])
                                }
                                showResult = true
                            })
                        })
                        
                        Spacer(minLength: 300)
                    }
                }
            }
        }
    }
}

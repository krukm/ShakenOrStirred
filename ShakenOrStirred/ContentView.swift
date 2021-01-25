import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State var drinkResult: DrinkObject?

    let networkManager = NetworkManager()
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Image("bg1")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .overlay(TintOverlay().opacity(0.65))
                    .edgesIgnoringSafeArea(.all)
                VStack() {
                    Text("I need a Drink!")
                        .font(Font.system(size: 65))
                        .fontWeight(.thin)
                        .foregroundColor(Color.white)
                        .padding(.all, 10.0)
                    SearchBar(text: $searchText, oncommit: {
                        networkManager.getDrinkJSON(drinkName: searchText, completion: { result in
                            print(result.drinks[0])
                        })
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TintOverlay: View {
    var body: some View {
        ZStack {
            Text(" ")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.black)
    }
}

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    var body: some View {
        Color(red: 153/255, green: 3/255, blue: 3/255).edgesIgnoringSafeArea(.all).overlay(
        VStack {
            Text("I need a Drink!")
                .font(Font.system(size: 65))
                .fontWeight(.thin)
                .foregroundColor(Color.white)
                .padding(.all, 10.0)
            SearchBar(text: $searchText)
        }.background(Image("bg1").resizable().scaledToFill()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

import Foundation
import SwiftUI

struct DrinkListView: View {
    @Binding var showResultView: Bool
    @ObservedObject var viewModel: ViewModel
    @State var showListView: Bool = false
    @State var searchType: Int
        
    var body: some View {
        List(viewModel.drinks.drinks.indexed(), id: \.1.self) { drink in
            NavigationLink(destination: ResultView(viewModel: viewModel, searchType: searchType, drinkNumber: drink.index)) {
                HStack {
                    IconImageView(imageURL: URL(string: drink.element.strDrinkThumb ?? ""))
                    Text("\(drink.element.strDrink)")
                        .foregroundColor(Colors.zeus)
                        .padding()
                }
            }
        }
        .padding(.top)
        .colorMultiply(Colors.wafer)
        .background(Colors.wafer)
        .ignoresSafeArea(.all)
    }
    
    private func ingredientResultView(id: String, drink: Drink, index: Int) -> some View {
        let view = HStack {
            IconImageView(imageURL: URL(string: drink.strDrinkThumb ?? ""))
            Text("\(drink.strDrink)")
                .foregroundColor(Colors.zeus)
                .padding()
        }.background(NavigationLink("", destination: ResultView(viewModel: viewModel, searchType: SearchType.id.asInt(), drinkNumber: index)))
        
        return view
    }
}

extension UIImage {
    var rounded: UIImage? {
        UIGraphicsBeginImageContext(size)
        UIBezierPath(ovalIn: CGRect(origin: .zero, size: size)).addClip()
        self.draw(at: .zero)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

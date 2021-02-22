import SwiftUI
import Combine

struct ResultListView: View {
    @ObservedObject var viewModel: ViewModel
        
    var body: some View {
        List(viewModel.drinks.drinks.indexed(), id: \.1.self) { drink in
            NavigationLink(destination: ResultView(viewModel: viewModel, drinkNumber: drink.index)) {
                HStack {
                    IconImageView(imageURL: URL(string: drink.element.strDrinkThumb ?? ""))
                    Text("\(drink.element.strDrink)")
                        .foregroundColor(Colors.zeus)
                        .padding()
                }
            }
        }
        .background(Color.clear)
    }
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = UIColor(Colors.arrowTown)
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

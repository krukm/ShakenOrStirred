import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: ViewModel
    var drinkNumber: Int
    
    var body: some View {
        let result = viewModel.drinks.drinks[drinkNumber]
        
        let urlString = result.strDrinkThumb
        let url = URL(string: urlString ?? "")
        
        let name = result.strDrink
        let catergory = result.strCategory
        let instructions = result.strInstructions
        
        let ingredient1 = result.strIngredient1 ?? ""
        let ingredient2 = result.strIngredient2
        let ingredient3 = result.strIngredient3
        let ingredient4 = result.strIngredient4
        let ingredient5 = result.strIngredient5
        let ingredient6 = result.strIngredient6
        let ingredient7 = result.strIngredient7
        let ingredient8 = result.strIngredient8
        let ingredient9 = result.strIngredient9
        let ingredient10 = result.strIngredient10
        let ingredient11 = result.strIngredient11
        let ingredient12 = result.strIngredient12
        let ingredient13 = result.strIngredient13
        let ingredient14 = result.strIngredient14
        let ingredient15 = result.strIngredient15
        
        let measurement1 = result.strMeasure1 ?? ""
        let measurement2 = result.strMeasure2
        let measurement3 = result.strMeasure3
        let measurement4 = result.strMeasure4
        let measurement5 = result.strMeasure5
        let measurement6 = result.strMeasure6
        let measurement7 = result.strMeasure7
        let measurement8 = result.strMeasure8
        let measurement9 = result.strMeasure9
        let measurement10 = result.strMeasure10
        let measurement11 = result.strMeasure11
        let measurement12 = result.strMeasure12
        let measurement13 = result.strMeasure13
        let measurement14 = result.strMeasure14
        let measurement15 = result.strMeasure15
        
        VStack(alignment: .center, spacing: 8) {
            Group {
                Text(name)
                    .font(.largeTitle)
                if let catergory = catergory {
                    Text(catergory).font(.subheadline)
                }
                ApiImageView(imageURL: url)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Group {
                            Text("\(checkClToOz(str: measurement1)) \(ingredient1)")
                                .font(.body)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.leading)
                            
                            if let measurement2 = measurement2, let ingredient2 = ingredient2 {
                                Text("\(checkClToOz(str: measurement2)) \(ingredient2)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            if let measurement3 = measurement3, let ingredient3 = ingredient3 {
                                Text("\(checkClToOz(str: measurement3)) \(ingredient3)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            if let measurement4 = measurement4, let ingredient4 = ingredient4 {
                                Text("\(checkClToOz(str: measurement4)) \(ingredient4)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)

                            }
                            
                            if let measurement5 = measurement5, let ingredient5 = ingredient5 {
                                Text("\(checkClToOz(str: measurement5)) \(ingredient5)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)

                            }
                            
                            if let measurement6 = measurement6, let ingredient6 = ingredient6 {
                                Text("\(checkClToOz(str: measurement6)) \(ingredient6)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)

                            }
                            
                            if let measurement7 = measurement7, let ingredient7 = ingredient7 {
                                Text("\(checkClToOz(str: measurement7)) \(ingredient7)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)

                            }
                            
                            if let measurement8 = measurement8, let ingredient8 = ingredient8 {
                                Text("\(checkClToOz(str: measurement8)) \(ingredient8)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)

                            }
                            
                            if let measurement9 = measurement9, let ingredient9 = ingredient9 {
                                Text("\(checkClToOz(str: measurement9)) \(ingredient9)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            if let measurement10 = measurement10, let ingredient10 = ingredient10 {
                                Text("\(checkClToOz(str: measurement10)) \(ingredient10)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        
                        Group {
                            if let measurement11 = measurement11, let ingredient11 = ingredient11 {
                                Text("\(checkClToOz(str: measurement11)) \(ingredient11)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            if let measurement12 = measurement12, let ingredient12 = ingredient12 {
                                Text("\(checkClToOz(str: measurement12)) \(ingredient12)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            if let measurement13 = measurement13, let ingredient13 = ingredient13 {
                                Text("\(checkClToOz(str: measurement13)) \(ingredient13)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            if let measurement14 = measurement14, let ingredient14 = ingredient14 {
                                Text("\(checkClToOz(str: measurement14)) \(ingredient14)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            if let measurement15 = measurement15, let ingredient15 = ingredient15 {
                                Text("\(checkClToOz(str: measurement15)) \(ingredient15)")
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    
                    Spacer()
                }
                
                Divider()
                
                if let instructions = instructions {
                    Text(instructions)
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }.padding()
        }.background(Colors.wafer.ignoresSafeArea(.all)).foregroundColor(Colors.zeus)
    }
    
    func checkClToOz(str: String) -> String {
        var resultString = str
        
        if str.contains("cL") || str.contains("cl") {
            resultString = clipString(str: str, delimiter: " ")
            
            if let number = Double(resultString) {
                resultString = "\(convertClToOz(double: number)) oz"
            }
        }
        
        return  resultString
    }
    
    func clipString(str: String, delimiter: String) -> String {
        guard let stopIndex = str.range(of: delimiter)?.lowerBound else { return str }
        return .init(str.prefix(upTo: stopIndex))
    }
    
    func convertClToOz(double: Double) -> String {
        return String(format: "%.1f", (double * 0.33814))
    }
}

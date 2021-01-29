import SwiftUI

struct ResultView: View {
    @EnvironmentObject var drinkResultsArray: DrinkResults
    
    var body: some View {
        let urlString = drinkResultsArray.drinkResults[0].strDrinkThumb
        let url = URL(string: urlString ?? "")
        
        let name = drinkResultsArray.drinkResults[0].strDrink
        let catergory = drinkResultsArray.drinkResults[0].strCategory ?? ""
        
        let ingredient1 = drinkResultsArray.drinkResults[0].strIngredient1 ?? "Ingerdient 1 missing"
        let ingredient2 = drinkResultsArray.drinkResults[0].strIngredient2 ?? "Ingredient 2 missing"
        let ingredient3 = drinkResultsArray.drinkResults[0].strIngredient3 ?? ""
        let ingredient4 = drinkResultsArray.drinkResults[0].strIngredient4 ?? ""
        let ingredient5 = drinkResultsArray.drinkResults[0].strIngredient5 ?? ""
        let ingredient6 = drinkResultsArray.drinkResults[0].strIngredient6 ?? ""
        let ingredient7 = drinkResultsArray.drinkResults[0].strIngredient7 ?? ""
        let ingredient8 = drinkResultsArray.drinkResults[0].strIngredient8 ?? ""
        let ingredient9 = drinkResultsArray.drinkResults[0].strIngredient9 ?? ""
        let ingredient10 = drinkResultsArray.drinkResults[0].strIngredient10 ?? ""
        let ingredient11 = drinkResultsArray.drinkResults[0].strIngredient11 ?? ""
        let ingredient12 = drinkResultsArray.drinkResults[0].strIngredient12 ?? ""
        let ingredient13 = drinkResultsArray.drinkResults[0].strIngredient13 ?? ""
        let ingredient14 = drinkResultsArray.drinkResults[0].strIngredient14 ?? ""
        let ingredient15 = drinkResultsArray.drinkResults[0].strIngredient15 ?? ""
        
        let measurement1 = drinkResultsArray.drinkResults[0].strMeasure1 ?? "Measurment 1 missing"
        let measurement2 = drinkResultsArray.drinkResults[0].strMeasure2 ?? "Measurment 2 missing"
        let measurement3 = drinkResultsArray.drinkResults[0].strMeasure3 ?? ""
        let measurement4 = drinkResultsArray.drinkResults[0].strMeasure4 ?? ""
        let measurement5 = drinkResultsArray.drinkResults[0].strMeasure5 ?? ""
        let measurement6 = drinkResultsArray.drinkResults[0].strMeasure6 ?? ""
        let measurement7 = drinkResultsArray.drinkResults[0].strMeasure7 ?? ""
        let measurement8 = drinkResultsArray.drinkResults[0].strMeasure8 ?? ""
        let measurement9 = drinkResultsArray.drinkResults[0].strMeasure9 ?? ""
        let measurement10 = drinkResultsArray.drinkResults[0].strMeasure10 ?? ""
        let measurement11 = drinkResultsArray.drinkResults[0].strMeasure11 ?? ""
        let measurement12 = drinkResultsArray.drinkResults[0].strMeasure12 ?? ""
        let measurement13 = drinkResultsArray.drinkResults[0].strMeasure13 ?? ""
        let measurement14 = drinkResultsArray.drinkResults[0].strMeasure14 ?? ""
        let measurement15 = drinkResultsArray.drinkResults[0].strMeasure15 ?? ""
        
        VStack(spacing: 8) {
            Group {
                Text(name)
                    .font(.largeTitle)
                ApiImageView(imageURL: url)
                Text(catergory)
            }
            Spacer()
            Group {
                Text("\(measurement1) \(ingredient1)")
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                
                Text("\(measurement2) \(ingredient2)")
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                
                if let measurement3 = measurement3, let ingredient3 = ingredient3 {
                    Text("\(measurement3) \(ingredient3)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
                
                if let measurement4 = measurement4, let ingredient4 = ingredient4 {
                    Text("\(measurement4) \(ingredient4)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)

                }
                
                if let measurement5 = measurement5, let ingredient5 = ingredient5 {
                    Text("\(measurement5) \(ingredient5)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)

                }
                
                if let measurement6 = measurement6, let ingredient6 = ingredient6 {
                    Text("\(measurement6) \(ingredient6)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)

                }
                
                if let measurement7 = measurement7, let ingredient7 = ingredient7 {
                    Text("\(measurement7) \(ingredient7)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)

                }
                
                if let measurement8 = measurement8, let ingredient8 = ingredient8 {
                    Text("\(measurement8) \(ingredient8)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)

                }
                
                if let measurement9 = measurement9, let ingredient9 = ingredient9 {
                    Text("\(measurement9) \(ingredient9)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
                
                if let measurement10 = measurement10, let ingredient10 = ingredient10 {
                    Text("\(measurement10) \(ingredient10)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
            }
            Group {
                if let measurement11 = measurement11, let _ = ingredient11 {
                    Text("\(measurement11) \(ingredient11)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
                
                if let measurement12 = measurement12, let ingredient12 = ingredient12 {
                    Text("\(measurement12) \(ingredient12)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
                
                if let measurement13 = measurement13, let ingredient13 = ingredient13 {
                    Text("\(measurement13) \(ingredient13)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
                
                if let measurement14 = measurement14, let ingredient14 = ingredient14 {
                    Text("\(measurement14) \(ingredient14)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
                
                if let measurement15 = measurement15, let ingredient15 = ingredient15 {
                    Text("\(measurement15) \(ingredient15)")
                        .font(.body)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.leading)
                }
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
    }
}

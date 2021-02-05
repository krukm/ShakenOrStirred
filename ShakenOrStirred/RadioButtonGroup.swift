import Foundation
import SwiftUI

struct RadioButtonGroups: View {
    @State var selectedId: Int = SearchType.name.asInt()
    let callback: (Int) -> ()
    
    var body: some View {
        HStack() {
            Spacer(minLength: 150)
            radioNameSearch
            radioIngredientSearch
            Spacer()
        }
    }
    
    var radioNameSearch: some View {
        RadioButtonField(
            id: SearchType.name.asInt(),
            label: SearchType.name.rawValue,
            isMarked: selectedId == SearchType.name.asInt() ? true : false,
            callback: radioGroupCallback
        )
    }
    
    var radioIngredientSearch: some View {
        RadioButtonField(
            id: SearchType.ingredient.asInt(),
            label: SearchType.ingredient.rawValue,
            isMarked: selectedId == SearchType.ingredient.asInt() ? true : false,
            callback: radioGroupCallback
        )
    }
    
    func radioGroupCallback(id: Int) {
        selectedId = id
        callback(id)
    }
}

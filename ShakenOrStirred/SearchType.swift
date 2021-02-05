import Foundation
import SwiftUI

enum SearchType: String, CaseIterable {
    case name = "name"
    case ingredient = "ingredient"
    case id = "id"
    
    static var asArray: [SearchType] {
        return self.allCases
    }
    
    func asInt() -> Int {
        return SearchType.asArray.firstIndex(of: self)!
    }
}

import Foundation
import SwiftUI

struct RadioButtonField: View {
    let id: Int
    let label: String
    let isMarked:Bool
    let callback: (Int)->()
    
    init(id: Int, label:String, isMarked: Bool = false, callback: @escaping (Int)->()) {
        self.id = id
        self.label = label
        self.isMarked = isMarked
        self.callback = callback
    }
    
    var body: some View {
        
        Button(action:{
            self.callback(self.id)
        }) {
            HStack(alignment: .center) {
                Image(systemName: self.isMarked ? "largecircle.fill.circle" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(Colors.wafer)
                Text(label)
                    .font(Font.system(size: 14))
                Spacer()
            }.foregroundColor(Colors.wafer)
        }.foregroundColor(Colors.saddle)
    }
}

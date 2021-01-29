import SwiftUI

struct SearchBar: View {
    @State private var isEditing = false
    @Binding var text: String
    var oncommit: ()->()
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $text, onCommit: oncommit)
                .foregroundColor(Colors.saddle)
                .padding(7)
                .padding(.horizontal, 25)
                .accentColor(Colors.wafer)
                .background(Colors.arrowTown)
                .cornerRadius(8)
                .overlay(HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Colors.wafer)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Colors.wafer)
                                    .padding(.trailing, 8)
                            }
                        }
                }).padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.endEditing()
                }) {
                    Text("Cancel")
                        .foregroundColor(Colors.wafer)
                }.padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }
        }
    }
}

extension UIApplication {    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

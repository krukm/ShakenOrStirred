import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: ViewModel
    @ObservedObject var errorView: ErrorView
    @State private var isEditing = false
    
    var oncommit: ()->()
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $viewModel.searchString.string, onCommit: oncommit)
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
                            viewModel.searchString.string = ""
                            errorView.showErrorView = false
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(Colors.wafer)
                                .padding(.trailing, 8)
                        }
                    }
                })
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                    errorView.showErrorView = false
                }
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.viewModel.searchString.string = ""
                    errorView.showErrorView = false
                    UIApplication.shared.endEditing()
                }) {
                    Text("Cancel")
                        .foregroundColor(Colors.wafer)
                }.transition(AnyTransition.slide.animation(.easeInOut(duration: 5.0)))
                .padding(.trailing, 10)
            }
        }
    }
}

extension UIApplication {    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

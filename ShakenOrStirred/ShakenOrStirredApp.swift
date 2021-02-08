import SwiftUI

@main
struct ShakenOrStirredApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel(), errorView: ErrorView())
        }
    }
}

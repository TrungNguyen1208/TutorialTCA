import SwiftUI
import ComposableArchitecture

@main
struct TutorialTCAApp: App {
    
    static let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }
    
    var body: some Scene {
        WindowGroup {
            AppView(store: TutorialTCAApp.store)
        }
    }
}

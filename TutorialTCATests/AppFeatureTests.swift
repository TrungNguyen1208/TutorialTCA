@testable import TutorialTCA

import ComposableArchitecture
import XCTest

final class AppFeatureTests: XCTestCase {
    
    func incrementInFirstTab() async {
        let store = await TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(\.tab1.incrementButtonTapped) {
          $0.tab1.count = 1
        }
    }
}

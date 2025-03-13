@testable import TutorialTCA

import ComposableArchitecture
import XCTest

final class CounterFeatureTests: XCTestCase {
    
    func testCounter() async {
        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
        
        await store.send(.incrementButtonTapped) { state in
            state.count = 1
        }
        await store.send(.decrementButtonTapped) { state in
            state.count = 0
        }
    }
    
    func testTimer() async {
        let clock = TestClock()
        
        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: { state in
            state.continuousClock = clock
        }
        
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }
        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }
        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }
    
    func testNumberFact() async {
        let store = await TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.numberFact.fetch = { "\($0) is a good number." }
        }
        
        await store.send(.factButtonTapped) { state in
            state.isLoading = true
        }
        
        await store.receive(\.factResponse) { state in
            state.isLoading = false
            state.fact = "0 is a good number."
        }
    }
}

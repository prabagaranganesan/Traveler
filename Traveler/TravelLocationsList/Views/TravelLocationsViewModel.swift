//
//  TravelLocationsViewModel.swift
//  Traveler
//
//  Created by Prabhagaran Ganesan on 12/08/23.
//

import Foundation
import Combine
import SwiftUI

final class TravelLocationsViewModel: ObservableObject {
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
    private let container: DIContainer

    @Published private(set) var state = State.idle

    init(container: DIContainer) {
        self.container = container
        bindingState()
    }
    
    func getCatogories() -> [CatogoryItem] {
        let beach = CatogoryItem(imageName: "beach_cat", title: "Beach", isSelected: true)
        let mountain = CatogoryItem(imageName: "mountain_cat", title: "Mountain", isSelected: false)
        let waterFalls = CatogoryItem(imageName: "falls_cat", title: "Water Falls", isSelected: false)
        let forests = CatogoryItem(imageName: "forests_cat", title: "Forests", isSelected: false)
        return [beach, mountain, waterFalls, forests] //TODO: convert as json file
    }
    
    private func bindingState() {
        Publishers.system(initial: state,
                          reduce: Self.reduce,
                          scheduler: RunLoop.main,
                          feedbacks: [
                            whenLoading(),
                            userInput(input: input.eraseToAnyPublisher())
                          ])
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }
    
    func send(event: Event) {
        input.send(event)
    }
    
    func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading = state else { return Empty().eraseToAnyPublisher() }
            
            return self.container.interacters.travelLocationsInteractor.load(search: "Miami beaches")
                .map { $0.map(TravelLocation.init) }
                .map(Event.onTravelLocationLoaded)
                .catch { Just(Event.onfailedtoLoadLocations($0)) }
                .eraseToAnyPublisher()
        }
    }
    
    deinit {
        bag.removeAll() //TODO: check if it automatically removes
    }
}

extension TravelLocationsViewModel {
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle:
            switch event {
            case .onAppear:
                return .loading
            default:
                return state
            }
        case .loading:
            switch event {
            case .onfailedtoLoadLocations(let error):
                return .error(error)
            case .onTravelLocationLoaded(let travelLocations):
                return .loaded(travelLocations)
            default:
                return state
            }
        case .loaded:
            return state
        case .error:
            return state
            
        }
    }
}

extension TravelLocationsViewModel {
    func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback { _ in input }
    }
}

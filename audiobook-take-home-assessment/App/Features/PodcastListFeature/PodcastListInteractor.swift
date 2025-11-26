//
//  PodcastListInteractor.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Combine
import Foundation

protocol PodcastListInteractorInterface: AnyObject {
    // Expose current favorites for mapping
    var currentFavorites: Set<String> { get }
    // Forward UI/feature events the interactor cares about
    func handle(_ event: PodcastListEvent)
}

final class PodcastListInteractor: PodcastListInteractorInterface {
    // MARK: - Data Store
    
    @Published var dataStore: [Podcast] = []
    
    // MARK: - Dependencies
    
    private let favoritesStore: FavoritesStoreInterface
    
    // MARK: - Favorites Cache
    
    private var favorites: Set<String> = []
    @Published var currentFavorites: Set<String> = []
    
    private let eventSubject: PassthroughSubject<PodcastListEvent, Never>
    
    // MARK: - Init
    init(
        favoritesStore: FavoritesStoreInterface,
        eventSubject: PassthroughSubject<PodcastListEvent, Never>
    ) {
        self.favoritesStore = favoritesStore
        self.eventSubject = eventSubject
    }
    
    func handle(_ event: PodcastListEvent) {
        switch event {
        case .didSelectPodcast(let id):
            guard let podcast = dataStore.first(
                where: { $0.id == id }
            ) else {
                return
            }
            eventSubject.send(.selectedPodcast(podcast: podcast))
        case .loadNextPageRequested: break
        case .selectedPodcast(_): break // Handled by the feature.
        }
    }
}

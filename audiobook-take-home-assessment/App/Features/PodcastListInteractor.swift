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
    
    private var dataStore: [Podcast] = []
    
    // MARK: - Dependencies
    
    private let favoritesStore: FavoritesStoreInterface
    
    // MARK: - Favorites Cache
    
    private var favorites: Set<String> = []
    var currentFavorites: Set<String> { favorites }
    
    // MARK: - Init
    init(
        favoritesStore: FavoritesStoreInterface
    ) {
        self.favoritesStore = favoritesStore
    }
    
    func handle(_ event: PodcastListEvent) {
        switch event {
        case .didSelectPodcast(let id): print(id)
        case .loadNextPageRequested: break
        case .selectedPodcast(_): break
        }
    }
}

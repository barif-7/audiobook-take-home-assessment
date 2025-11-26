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
}

final class PodcastListInteractor: PodcastListInteractorInterface {
    // MARK: - Data Store
    private var dataStore: [Podcast] = []
    
    // MARK: - Dependencies
    private let favoritesStore: FavoritesStoreInterface
    
    // MARK: - Favorites Cache
    private var favorites: Set<String> = []
    var currentFavorites: Set<String> { favorites }
    
    init(
        favoritesStore: FavoritesStoreInterface
    ) {
        self.favoritesStore = favoritesStore
    }
}

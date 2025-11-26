//
//  FavoritesStoreInterface.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Combine

/// Abstraction that features (list/details) depend on.
protocol FavoritesStoreInterface: AnyObject {
    /// Emits the current set of favourited podcast IDs and any subsequent changes.
    var favoritesPublisher: AnyPublisher<Set<String>, Never> { get }

    /// Returns whether a given podcast is favourited.
    func isFavorite(id: String) -> Bool

    /// Toggles the favourite state for a given podcast.
    func toggleFavorite(id: String)

    /// Explicitly sets favourite state for a given podcast.
    func setFavorite(_ isFavorite: Bool, for id: String)
}

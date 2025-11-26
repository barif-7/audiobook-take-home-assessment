//
//  FavoritesStore.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Combine
import Foundation

/// Simple implementation of `FavoritesStoreInterface`using UserDefaults persistence.
final class FavoritesStore: FavoritesStoreInterface {

    // MARK: - Types

    private enum Constants {
        static let defaultsKey = "favoritePodcastIDs"
    }

    // MARK: - State

    private let subject: CurrentValueSubject<Set<String>, Never>
    private var favorites: Set<String> {
        didSet {
            subject.send(favorites)
            saveToDefaults()
        }
    }

    private let userDefaults: UserDefaults
    private let userDefaultsKey: String

    // MARK: - Init

    init(
        userDefaults: UserDefaults = .standard,
        userDefaultsKey: String = Constants.defaultsKey
    ) {
        self.userDefaults = userDefaults
        self.userDefaultsKey = userDefaultsKey

        let initial = FavoritesStore.loadFromDefaults(
            userDefaults: userDefaults,
            key: userDefaultsKey
        )

        self.favorites = initial
        self.subject = CurrentValueSubject(initial)
    }

    // MARK: - FavoritesStoreInterface

    var favoritesPublisher: AnyPublisher<Set<String>, Never> {
        subject.eraseToAnyPublisher()
    }

    func isFavorite(id: String) -> Bool {
        favorites.contains(id)
    }

    func toggleFavorite(id: String) {
        if favorites.contains(id) {
            favorites.remove(id)
        } else {
            favorites.insert(id)
        }
    }

    func setFavorite(_ isFavorite: Bool, for id: String) {
        if isFavorite {
            favorites.insert(id)
        } else {
            favorites.remove(id)
        }
    }

    // MARK: - Persistence

    private func saveToDefaults() {
        let array = Array(favorites)
        userDefaults.set(array, forKey: userDefaultsKey)
    }

    private static func loadFromDefaults(
        userDefaults: UserDefaults,
        key: String
    ) -> Set<String> {
        guard let array = userDefaults.array(forKey: key) as? [String] else {
            return []
        }
        return Set(array)
    }
}


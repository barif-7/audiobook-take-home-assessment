//
//  PodcastListFeature.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import UIKit

final class PodcastListFeature: RootFeature {
    // MARK: - Dependencies
    private let router: PodcastListRouterInterface
    private let favoritesStore: FavoritesStoreInterface
    
    // MARK: - Initializer
    init(
        router: PodcastListRouterInterface,
        favoritesStore: FavoritesStoreInterface
    ) {
        self.router = router
        self.favoritesStore = favoritesStore
    }
    
    // MARK: - RootFeature Conformance
    
    func make() -> UIViewController {
        return UIViewController()
    }
}

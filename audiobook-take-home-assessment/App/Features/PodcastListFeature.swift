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
    
    // MARK: - Feature Components
    
    private lazy var interactor: PodcastListInteractor = {
       PodcastListInteractor(
        favoritesStore: favoritesStore
       )
    }()
    
    private lazy var presenter: PodcastlistPresenter = {
        PodcastlistPresenter(interactor: interactor)
    }()
    
    lazy var viewController: PodcastListViewController = {
        PodcastListViewController(
            presenter: presenter
        )
    }()
    
    // MARK: - RootFeature Conformance
    
    func make() -> UIViewController {
        return viewController
    }
}

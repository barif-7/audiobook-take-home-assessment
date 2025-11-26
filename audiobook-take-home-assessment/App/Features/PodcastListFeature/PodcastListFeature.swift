//
//  PodcastListFeature.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Combine
import UIKit

final class PodcastListFeature: RootFeature {
    // MARK: Combine + Life-Cycle
    
    private let eventSubject: PassthroughSubject<PodcastListEvent, Never> = .init()
    private var cancellables = Set<AnyCancellable>()
    
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
        
        eventSubject.sink { [weak self] event in
            guard let self else { return }
            switch event {
            case .selectedPodcast(let podcast):
                // TODO: - Handle navigation to a podcasts detail screen here
                print(podcast)
            default:
                break
            }
        }.store(in: &cancellables)
    }
    
    // MARK: - Feature Components
    
    private lazy var interactor: PodcastListInteractor = {
       PodcastListInteractor(
        favoritesStore: favoritesStore,
        eventSubject: eventSubject
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

//
//  PodcastListPresenter.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

struct PodcastListViewState {
    var items: [PodcastListItem]
}

final class PodcastlistPresenter {
    // TODO: - Add Dependencies
    private let interactor: PodcastListInteractor
    // MARK: - Output
    var onStateChange: ((PodcastListViewState) -> Void)?
    
    // MARK: - Init
    init(interactor: PodcastListInteractor) {
        self.interactor = interactor
    }
    
    func handle(_ event: PodcastListEvent) {
        switch event {
        case .didSelectPodcast(let id): print(id)
        case .loadNextPageRequested: break
        case .selectedPodcast(_): break
        }
    }
}

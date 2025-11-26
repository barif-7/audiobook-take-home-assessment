//
//  PodcastListPresenter.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

struct PodcastListViewState {
    let isLoading: Bool
    let items: [PodcastListItem]
    let errorMessage: String?
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
        case .didSelectPodcast(let id):
            interactor.handle(.didSelectPodcast(id: id))
        case .loadNextPageRequested:
            onStateChange?(
                PodcastListViewState(
                    isLoading: true,
                    items: mapPodcasts(
                        interactor.dataStore,
                        favoriteIDs: interactor.currentFavorites
                    ),
                    errorMessage: nil
                )
            )
        case .selectedPodcast(_): break
        }
    }
    
    // MARK: - Mapping
    private func mapPodcasts(_ podcasts: [Podcast], favoriteIDs: Set<String>?) -> [PodcastListItem] {
        podcasts.map { podcast in
            PodcastListItem(
                id: podcast.id,
                title: podcast.title,
                subtitle: podcast.publisher,
                thumbnailURL: podcast.thumbnail,
                isFavorite: favoriteIDs?.contains(podcast.id) ?? false
            )
        }
    }
}

//
//  PodcastListService.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

protocol PodcastListProviderInterface {
    func fetchPodcasts(genreId: Int, page: Int) async throws -> APIPodcastListResponse
}

final class PodcastListService: PodcastListProviderInterface {
    private let client: HTTPClient
    private let actionFactory: HTTPActionFactory
    
    init(
        client: HTTPClient,
        actionFactory: HTTPActionFactory
    ) {
        self.client = client
        self.actionFactory = actionFactory
    }
    
    func fetchPodcasts(genreId: Int, page: Int) async throws -> APIPodcastListResponse {
        let action = actionFactory
            .makeBestPodcastsAction(
                genreId: genreId,
                page: page
            )
        return try await action.run(using: client)
    }
}


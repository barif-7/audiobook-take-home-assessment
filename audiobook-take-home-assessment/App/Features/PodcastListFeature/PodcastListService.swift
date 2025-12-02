//
//  PodcastListService.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-12-01.
//

import Combine
import UIKit

protocol PodcastListServiceProtocol: AnyObject {
    func fetchPodcastList(_ genre: Int?, page: Int) async throws -> APIPodcastListResponse
}

final class PodcastListService: PodcastListServiceProtocol {
    private let httpActionFactory: HTTPActionFactory
    private let httpClient: URLSessionHTTPClient
    
    init(httpActionFactory: HTTPActionFactory, httpClient: URLSessionHTTPClient) {
        self.httpActionFactory = httpActionFactory
        self.httpClient = httpClient
    }
    
    func fetchPodcastList(_ genre: Int? = 93, page: Int) async throws -> APIPodcastListResponse {
        let action = httpActionFactory.makeBestPodcastsAction(
            genreId: genre ?? 93,
            page: page
        )
        return try await action.run(using: httpClient)
    }
}

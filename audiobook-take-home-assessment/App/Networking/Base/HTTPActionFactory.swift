//
//  HTTPActionFactory.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

struct HTTPActionFactory {
    struct Config {
        let baseURL: URL
        let apiKey: String
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
    }
}

extension HTTPActionFactory {
    func makeBestPodcastsAction(
        genreId: Int,
        page: Int
    ) -> PodcastListHTTPAction {
        PodcastListHTTPAction(
            baseURL: config.baseURL,
            apiKey: config.apiKey,
            genreId: genreId,
            page: page
        )
    }
}

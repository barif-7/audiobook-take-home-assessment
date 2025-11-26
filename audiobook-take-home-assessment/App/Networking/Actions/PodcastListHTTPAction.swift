//
//  PodcastListHTTPAction.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

struct PodcastListHTTPAction: HTTPAction {
    typealias Response = APIPodcastListResponse

    let request: URLRequest
    
    init(
        baseURL: URL,
        apiKey: String,
        genreId: Int,
        page: Int
    ) {
        var components = URLComponents(
            url: baseURL.appendingPathComponent("best_podcasts"),
            resolvingAgainstBaseURL: false
        )!

        components.queryItems = [
            URLQueryItem(name: "genre_id", value: String(genreId)),
            URLQueryItem(name: "page", value: String(page))
        ]

        var req = URLRequest(url: components.url!)
        req.httpMethod = "GET"
        req.setValue(apiKey, forHTTPHeaderField: "X-ListenAPI-Key")
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        self.request = req
    }
}

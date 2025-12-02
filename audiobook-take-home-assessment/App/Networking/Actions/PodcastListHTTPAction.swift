//
//  PodcastListHTTPAction.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

struct PodcastListHTTPAction: HTTPAction {
    typealias Response = APIPodcastListResponse

    private let baseURL: URL = URL(string: "https://listen-api-test.listennotes.com/api/v2/")!
    
    let request: URLRequest
    
    init(
        apiKey: String,
        query: String
    ) {
        var components = URLComponents(
            url: baseURL.appendingPathComponent("search"),
            resolvingAgainstBaseURL: false
        )!

        components.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]

        var req = URLRequest(url: components.url!)
        req.httpMethod = "GET"
        req.setValue(apiKey, forHTTPHeaderField: "X-ListenAPI-Key")
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        self.request = req
    }
}

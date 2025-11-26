//
//  HTTPClient.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

public protocol HTTPClient {
    func perform(_ request: URLRequest) async throws -> (Data, URLResponse)
}

final public class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    public func perform(_ request: URLRequest) async throws -> (Data, URLResponse) {
        try await session.data(for: request)
    }
}

public enum HTTPError: Error {
    case invalidStatusCode(Int)
    case decoding(Error)
    case cancelled
}

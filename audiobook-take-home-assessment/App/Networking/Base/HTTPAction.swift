//
//  HttpAction.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

protocol HTTPAction {
    associatedtype Response: Decodable

    var request: URLRequest { get }

    func run(using client: HTTPClient) async throws -> Response
}

extension HTTPAction {
    func run(using client: HTTPClient) async throws -> Response {
        let (data, response) = try await client.perform(request)

        guard let http = response as? HTTPURLResponse,
              200..<300 ~= http.statusCode else {
            throw HTTPError.invalidStatusCode(
                (response as? HTTPURLResponse)?.statusCode ?? -1
            )
        }
        
        do {
            return try JSONDecoder().decode(Response.self, from: data)
        } catch {
            throw HTTPError.decoding(error)
        }
    }
}


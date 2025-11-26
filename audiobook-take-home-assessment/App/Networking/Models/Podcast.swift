//
//  Podcast.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

protocol BaseModel: Decodable, Identifiable, Hashable {
    var id: String { get }
}

struct Podcast: BaseModel {
    let id: String
    let title: String
    let publisher: String
    let thumbnail: String
    let description: String?
}

struct APIPodcastListResponse: Decodable {
    let id: Int
    let name: String
    let total: Int
    let hasNext: Bool
    let podcasts: [Podcast]
    let parentId: Int
    let pageNumber: Int
    let hasPrevious: Bool
    let listennotesURL: String
    let nextPageNumber: Int
    let previousPageNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case total
        case hasNext = "has_next"
        case podcasts
        case parentId = "parent_id"
        case pageNumber = "page_number"
        case hasPrevious = "has_previous"
        case listennotesURL = "listennotes_url"
        case nextPageNumber = "next_page_number"
        case previousPageNumber = "previous_page_number"
    }
}

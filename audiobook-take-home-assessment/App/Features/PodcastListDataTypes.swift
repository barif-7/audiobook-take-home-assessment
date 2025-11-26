//
//  PodcastListDataTypes.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Foundation

enum PodcastListEvent {
    /// User tapped on a podcast cell.
    case didSelectPodcast(id: String)
    /// User scrolled near the bottom and wants the next page.
    case loadNextPageRequested
    /// Handled at the feature level for routing.
    case selectedPodcast(podcast: Podcast)
}

struct PodcastListItem {
    let id: String
    let title: String
    let subtitle: String
    let thumbnailURL: String
    var isFavorite: Bool
}

//
//  PodcastListRouter.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import UIKit

protocol PodcastListRouterInterface: Router {
    // Accept a ready-made details feature
    // Provides enhanced type-safety and encapsulation.
    // TODO: - Add a show method that is initialized with a feature class.
    
    // Accept a pre-built view controller directly
    func showPodcastDetail(viewController: UIViewController)
}

final class PodcastListRouter: PodcastListRouterInterface {
    internal weak var navigationController: UINavigationController?

    init(
        navigationController: UINavigationController?
    ) {
        self.navigationController = navigationController
    }
    
    // MARK: - Pushed to the navigation stack.
    func push(
        _ viewController: UIViewController,
        animated: Bool = true
    ) {
        navigationController?.pushViewController(
            viewController,
            animated: animated
        )
    }
    
    // MARK: - Routing Options
    
    func showPodcastDetail(viewController: UIViewController) {
        push(viewController, animated: true)
    }
}


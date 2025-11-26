//
//  PodcastListViewController.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Combine
import UIKit

final class PodcastListViewController: UIViewController {
    // MARK: - Dependencies
    private let presenter: PodcastlistPresenter
    
    // TODO: - Create PodcastListView and ListView abstraction
    
    // MARK: - Init
    init(presenter: PodcastlistPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        presenter.onStateChange = { [weak self] viewState in
            guard let self else { return }
            self.apply(state: viewState)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PodcastListViewController {
    // TODO: - Fill out once PodcastListView is added.
    fileprivate func apply(state: PodcastListViewState) {}
}

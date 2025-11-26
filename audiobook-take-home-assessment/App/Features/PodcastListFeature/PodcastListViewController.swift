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
    
    // MARK: - UI
    private let listView = PodcastListView()
    
    // MARK: - Init
    init(presenter: PodcastlistPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        presenter.onStateChange = { [weak self] viewState in
            guard let self else { return }
            self.apply(state: viewState)
        }
        
        // Subscribe to the view's events (selection, pagination, etc.)
        listView.eventPublisher.sink { [weak self] event in
            guard let self else { return }
            switch event {
            case .didSelect(let id):
                self.presenter.handle(.didSelectPodcast(id: id))
            case .loadNextPageRequested:
                self.presenter.handle(.loadNextPageRequested)
            }
        }.store(in: &cancellables)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Private
extension PodcastListViewController {
    fileprivate func apply(state: PodcastListViewState) {
        guard !state.items.isEmpty else {
            listView.showMessage("No Podcasts Found")
            return
        }
        listView.items = state.items
    }
}

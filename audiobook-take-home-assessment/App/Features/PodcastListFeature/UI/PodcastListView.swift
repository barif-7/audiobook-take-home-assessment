//
//  PodcastListView.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import Combine
import UIKit

protocol ListView: AnyObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    associatedtype PresentationObject
    /// Data source
    var items: [PresentationObject] { get set }
    /// Passes a boolean for callers to decide when to show certain UI e.g. loading indicator
    func showLoading(_ loading: Bool)
    /// Passes an optional string for callers to show the user a message e.g. "No Podcasts Found"
    func showMessage(_ text: String?)
}

final class PodcastListView: UIView, ListView {
    typealias PresentationObject = PodcastListItem
    
    // MARK: - Subviews
    private let titleLabel: UILabel = {
        let label = UILabel()
        let basePointSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
        let boldLargeTitle = UIFont.systemFont(ofSize: basePointSize, weight: .bold)
        label.font = UIFontMetrics(forTextStyle: .largeTitle).scaledFont(for: boldLargeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.text = "Podcasts"
        label.numberOfLines = 1
        return label
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let messageLabel = UILabel()
    
    // MARK: - Data
    
    var items: [PodcastListItem] = [] {
        didSet { collectionView.reloadData() }
    }
    
    // MARK: - Publisher
    
    // Exposes read-only publisher, keeping subject private.
    var eventPublisher: AnyPublisher<PodcastListViewEvent, Never> {
        eventSubject.eraseToAnyPublisher()
    }
    private let eventSubject = PassthroughSubject<PodcastListViewEvent, Never>()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Public API
extension PodcastListView {
    func showLoading(_ loading: Bool) {
        if loading {
            messageLabel.isHidden = true
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func showMessage(_ text: String?) {
        messageLabel.isHidden = (text == nil)
        messageLabel.text = text
    }
}

// MARK: - Private Setup
extension PodcastListView {
    func setupView() {
        backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.register(
            PodcastListViewCell.self,
            forCellWithReuseIdentifier: PodcastListViewCell.reuseIdentifier
        )
        
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = .preferredFont(forTextStyle: .subheadline)
        messageLabel.adjustsFontForContentSizeCategory = true
        messageLabel.textColor = .secondaryLabel
        messageLabel.isHidden = true
        
        activityIndicator.hidesWhenStopped = true
        
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(messageLabel)
        addSubview(activityIndicator)
    }
    
    func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let titleHeight = titleLabel.font.lineHeight
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 8
            ),
            titleLabel.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16
            ),
            titleLabel.trailingAnchor.constraint(
                lessThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16
            ),
            titleLabel.heightAnchor.constraint(equalToConstant: titleHeight),
            
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - UICollectionViewDataSource & Delegate
extension PodcastListView {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return items.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PodcastListViewCell.reuseIdentifier,
            for: indexPath
        ) as? PodcastListViewCell else {
            return UICollectionViewCell()
        }
        let item = items[indexPath.item]
        cell.configure(with: item)
        
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let item = items[indexPath.item]
        eventSubject.send(.didSelect(id: item.id))
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 120)
    }
}


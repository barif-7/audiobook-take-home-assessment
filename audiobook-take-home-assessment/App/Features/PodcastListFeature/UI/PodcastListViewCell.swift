//
//  PodcastListViewCell.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import UIKit

final class PodcastListViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PodcastCell"
    
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let favoritedLabel = UILabel()
    private let separatorView = UIView()
    
    // imageURL cache
    private static let imageCache = NSCache<NSURL, UIImage>()
    private var currentImageURL: NSURL?
    private var imageTask: URLSessionDataTask?
    
    func configure(with item: PodcastListItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        favoritedLabel.isHidden = !item.isFavorite
        
        accessibilityLabel = "\(item.title), \(item.subtitle)"
        
        loadImage(from: item.thumbnailURL)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    private func reset() {
        imageTask?.cancel()
        imageTask = nil
        currentImageURL = nil
        thumbnailImageView.image = nil
        favoritedLabel.isHidden = true
    }
}

// MARK: - Private Setup
private extension PodcastListViewCell {
    func setup() {
        contentView.isAccessibilityElement = true

        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.backgroundColor = UIColor.secondarySystemFill
        
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.numberOfLines = 2
        
        subtitleLabel.font = .preferredFont(forTextStyle: .subheadline)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 1

        favoritedLabel.font = .preferredFont(forTextStyle: .footnote)
        favoritedLabel.adjustsFontForContentSizeCategory = true
        favoritedLabel.textColor = .systemGreen
        favoritedLabel.text = "Favourited"
        favoritedLabel.isHidden = true
        
        // Separator line
        separatorView.backgroundColor = .separator

        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(favoritedLabel)
        contentView.addSubview(separatorView)
    }
    
    func layout() {
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        favoritedLabel.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        let onePixel = 1.0 / traitCollection.displayScale
        
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            thumbnailImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            // Increased thumbnail size
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 80),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),

            favoritedLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            favoritedLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            favoritedLabel.trailingAnchor.constraint(lessThanOrEqualTo: titleLabel.trailingAnchor),
            favoritedLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8),

            separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: onePixel)
        ])
    }
    
    func loadImage(from urlString: String) {
        thumbnailImageView.image = nil
        imageTask?.cancel()
        imageTask = nil

        guard let url = URL(string: urlString) else { return }
        let nsURL = url as NSURL
        currentImageURL = nsURL
        
        if let cached = PodcastListViewCell.imageCache.object(
            forKey: nsURL
        ) {
            thumbnailImageView.image = cached
            return
        }
        
        imageTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self, let data, let image = UIImage(data: data) else { return }
            PodcastListViewCell.imageCache.setObject(image, forKey: nsURL)
            
            DispatchQueue.main.async {
                if self.currentImageURL == nsURL {
                    self.thumbnailImageView.image = image
                }
            }
        }
        imageTask?.resume()
    }
}


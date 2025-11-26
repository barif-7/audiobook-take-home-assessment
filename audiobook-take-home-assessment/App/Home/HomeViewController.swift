//
//  HomeViewController.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import UIKit

final class HomeViewController: ViewController {
    // TODO: - Add feature dependencies here...
    
    private let rootFeature: RootFeature
    private var embeddedViewController: UIViewController?

    init(rootFeature: RootFeature) {
        self.rootFeature = rootFeature
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let child = rootFeature.make()
        embed(child)
    }

    // MARK: - Embedding
    private func embed(_ child: UIViewController) {
        if let current = embeddedViewController {
            current.willMove(toParent: nil)
            current.view.removeFromSuperview()
            current.removeFromParent()
        }

        addChild(child)
        view.addSubview(child.view)
        
        child.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(
                equalTo: view.topAnchor)
            ,
            child.view.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            child.view.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            child.view.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])

        child.didMove(toParent: self)
        embeddedViewController = child
    }
}

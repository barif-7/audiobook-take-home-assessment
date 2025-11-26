//
//  SceneDelegate.swift
//  audiobook-take-home-assessment
//
//  Created by Basil Arif on 2025-11-26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let rootFeature: RootFeature = buildPodcastListFeature()
        
        let rootVC = HomeViewController(
            rootFeature: rootFeature
        )
        window.rootViewController = rootVC
        self.window = window
        
        window.makeKeyAndVisible()
    }
    
    private func buildPodcastListFeature() -> PodcastListFeature {
        // Build the router (navigation controller will be provided by the feature at make() time)
        let router = PodcastListRouter(navigationController: nil)
        let favoritesStore = FavoritesStore()
        
        return PodcastListFeature(
            router: router,
            favoritesStore: favoritesStore
        )
    }
    
    // MARK: - SceneDelegate Conformances

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}


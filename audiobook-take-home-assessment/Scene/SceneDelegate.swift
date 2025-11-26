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
        
        // TODO: - Build any dependencies to inject as HomeViewController will be the single source of truth & the point of entry for any feature class.
        
        let rootFeature: RootFeature = PodcastListFeature()
        
        let rootVC = HomeViewController(
            rootFeature: rootFeature
        )
        window.rootViewController = rootVC
        self.window = window
        
        window.makeKeyAndVisible()
    }
    
    // MARK: - Conformances

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}


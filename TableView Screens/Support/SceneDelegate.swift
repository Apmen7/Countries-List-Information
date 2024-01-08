//
//  SceneDelegate.swift
//  iOS Test Task
//
//  Created by Armen on 28.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()

        let controller = MainViewController()
        let navController = UINavigationController(rootViewController: controller)
        window?.rootViewController = navController
    }

}

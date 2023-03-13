//
//  SceneDelegate.swift
//  Nusinsa
//
//  Created by hana on 2022/08/12.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.backgroundColor = .systemBackground
        self.window?.tintColor = .label
        
        self.window?.rootViewController = MainViewController()
        self.window?.makeKeyAndVisible()
    }

}


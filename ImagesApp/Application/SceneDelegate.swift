//
//  SceneDelegate.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 27/01/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(windowScene: windowScene)
        coordinator = AppCoordinator(window: window!)
        coordinator?.start()
    }

}


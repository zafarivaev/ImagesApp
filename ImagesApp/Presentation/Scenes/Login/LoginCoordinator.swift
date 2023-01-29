//
//  LoginCoordinator.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class LoginCoordinator: Coordinator {
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let authService: AuthServiceProtocol = AuthServiceMock()
        let loginViewModel = LoginViewModel(authService: authService)
        let loginViewController = LoginViewController()
        loginViewController.coordinator = self
        loginViewController.viewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func coordinateToRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
        coordinate(to: registerCoordinator)
    }
    
    func coordinateToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        coordinate(to: homeCoordinator)
    }
}

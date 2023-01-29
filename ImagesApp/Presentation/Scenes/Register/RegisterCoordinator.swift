//
//  RegisterCoordinator.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class RegisterCoordinator: Coordinator {
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let authService: AuthServiceProtocol = AuthServiceMock()
        let registerViewModel: RegisterViewModelProtocol = RegisterViewModel(authService: authService)
        let registerViewController = RegisterViewController()
        registerViewController.coordinator = self
        registerViewController.viewModel = registerViewModel
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func coordinateToHome() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        coordinate(to: homeCoordinator)
    }
}


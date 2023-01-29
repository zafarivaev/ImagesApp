//
//  HomeCoordinator.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class HomeCoordinator: Coordinator {
    unowned let navigationController: UINavigationController
    private weak var homeNavigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let networkClient: NetworkClientProtocol = NetworkClient()
        let homeViewModel = HomeViewModel(repository: PhotosRepository(networkClient: networkClient))
        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        homeViewController.viewModel = homeViewModel
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.modalPresentationStyle = .fullScreen
        navigationController.present(homeNavigationController, animated: true)
        self.homeNavigationController = homeNavigationController
    }
    
    func coordinateToDetail(for photo: PixabayPhoto) {
        guard let homeNavigationController = homeNavigationController else { return }
        let coordinator = ImageDetailCoordinator(navigationController: homeNavigationController, photo: photo)
        coordinate(to: coordinator)
    }
}

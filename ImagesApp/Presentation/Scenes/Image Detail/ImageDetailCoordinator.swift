//
//  ImageDetailCoordinator.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class ImageDetailCoordinator: Coordinator {
    unowned let navigationController: UINavigationController
    let photo: PixabayPhoto
    
    init(navigationController: UINavigationController, photo: PixabayPhoto) {
        self.navigationController = navigationController
        self.photo = photo
    }
    
    func start() {
        let networkClient: NetworkClientProtocol = NetworkClient()
        let imageDetailViewModel = ImageDetailViewModel(repository: PhotosRepository(networkClient: networkClient), photo: photo)
        let imageDetailViewController = ImageDetailViewController()
        imageDetailViewController.coordinator = self
        imageDetailViewController.viewModel = imageDetailViewModel
        navigationController.pushViewController(imageDetailViewController, animated: true)
    }

}



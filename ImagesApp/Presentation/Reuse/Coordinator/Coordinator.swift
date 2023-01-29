//
//  Coordinator.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import Foundation

protocol Coordinator: AnyObject {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

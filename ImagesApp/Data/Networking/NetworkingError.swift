//
//  NetworkingError.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case decodingFailed
    case unknown
}

//
//  PixabayPhoto.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import Foundation

// MARK: - Welcome
struct PixabayPhotosResponse: Codable {
    let photos: [PixabayPhoto]
    
    enum CodingKeys: String, CodingKey {
        case photos = "hits"
    }
}

// MARK: - Hit
struct PixabayPhoto: Codable {
    let id: Int
    let type: PhotoType
    let tags: String
    let previewURL: String
    let webformatURL: String
    let webformatWidth, webformatHeight: Int
    let imageSize, views: Int
    let downloads, collections, likes, comments: Int
    let user: String
}

enum PhotoType: String, Codable {
    case illustration = "illustration"
    case photo = "photo"
}

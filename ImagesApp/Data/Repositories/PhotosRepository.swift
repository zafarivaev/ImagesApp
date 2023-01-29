//
//  PhotosRepository.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import RxSwift

protocol PhotosRepositoryProtocol: AnyObject {
    func fetchPhotos() -> Observable<Result<PixabayPhotosResponse, Error>>
    func fetchImageData(for imageUrlString: String) -> Observable<Result<Data, Error>>
}

final class PhotosRepository: PhotosRepositoryProtocol {
    private let networkClient: NetworkClientProtocol
    private let cache = NSCache<NSString, NSData>()
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func fetchPhotos() -> Observable<Result<PixabayPhotosResponse, Error>> {
        let endpoint = Endpoint.photos
        return networkClient.get(PixabayPhotosResponse.self, url: endpoint.url)
    }
    
    func fetchImageData(for imageUrlString: String) -> Observable<Result<Data, Error>> {
        if let cachedData = cache.object(forKey: imageUrlString as NSString) {
            print("Using cached data for photo URL: \(imageUrlString)")
            return .just(.success(cachedData as Data))
        }
        guard let url = URL(string: imageUrlString) else {
            return .just(.failure(NetworkingError.invalidURL))
        }
        return networkClient.getData(url)
            .do { [weak self] result in
                if case let .success(data) = result {
                    self?.cache.setObject(data as NSData, forKey: imageUrlString as NSString)
                }
            }
    }
}

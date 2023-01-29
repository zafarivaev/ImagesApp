//
//  HomeViewModel.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import RxSwift
import RxCocoa

protocol HomeViewModelProtocol: AnyObject {
    var sectionRelay: PublishRelay<TableSection> { get }
    var photos: [PixabayPhoto] { get }
    
    func fetchPhotos()
    func fetchImage(for index: Int) -> Observable<UIImage?>
}

final class HomeViewModel: HomeViewModelProtocol {
    private let repository: PhotosRepositoryProtocol
    let sectionRelay = PublishRelay<TableSection>()
    private let disposeBag = DisposeBag()
    public var photos: [PixabayPhoto] = []
    
    init(repository: PhotosRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchPhotos() {
        repository.fetchPhotos()
            .do(onNext: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(response):
                    let section = self.createSection(from: response.photos)
                    self.sectionRelay.accept(section)
                    self.photos = response.photos
                case let .failure(error):
                    print(error)
                }
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func fetchImage(for index: Int) -> Observable<UIImage?> {
        repository.fetchImageData(for: photos[index].previewURL)
            .map { result in
                if case let .success(data) = result, let image = UIImage(data: data) {
                    return image
                } else {
                    return nil
                }
            }
    }
    
    private func createSection(from photos: [PixabayPhoto]) -> TableSection {
        return TableSection(rowModels: photos.map {
            ImageTableViewCellViewModel(author: $0.user)
        })
    }
}

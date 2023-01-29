//
//  ImageDetailViewModel.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import RxSwift
import RxCocoa

protocol ImageDetailViewModelProtocol: AnyObject {
    var sectionsRelay: PublishRelay<[TableSection]> { get }
    
    func displayData()
    func fetchImage() -> Observable<UIImage?>
}

final class ImageDetailViewModel: ImageDetailViewModelProtocol {
    private let repository: PhotosRepositoryProtocol
    private let photo: PixabayPhoto
    let sectionsRelay = PublishRelay<[TableSection]>()
    private let disposeBag = DisposeBag()
    
    init(repository: PhotosRepositoryProtocol, photo: PixabayPhoto) {
        self.repository = repository
        self.photo = photo
    }
    
    func displayData() {
        sectionsRelay.accept([
            buildFirstSection(),
            buildSecondSection()
        ])
    }
    
    func fetchImage() -> Observable<UIImage?> {
        repository.fetchImageData(for: photo.webformatURL)
            .map { result in
                if case let .success(data) = result, let image = UIImage(data: data) {
                    return image
                } else {
                    return nil
                }
            }
    }
    
    private func buildFirstSection() -> TableSection {
        return TableSection(
            headerModel: TitleHeaderViewModel(title: "Section 1"),
            rowModels: [
                LargeImageTableViewCellViewModel(),
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "Size", detailTitle: "\(photo.imageSize)"
                ),
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "Type", detailTitle: photo.type.rawValue
                ),
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "Tags", detailTitle: photo.tags
                )
        ])
    }
    
    private func buildSecondSection() -> TableSection {
        return TableSection(
            headerModel: TitleHeaderViewModel(title: "Section 2"),
            rowModels: [
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "User", detailTitle: photo.user
                ),
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "Views", detailTitle: "\(photo.views)"
                ),
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "Likes", detailTitle: "\(photo.likes)"
                ),
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "Comments", detailTitle: "\(photo.comments)"
                ),
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "Favorites", detailTitle: "\(photo.collections)"
                ),
                TwoTitlesTableViewCellViewModel(
                    mainTitle: "Downloads", detailTitle: "\(photo.downloads)"
                ),
        ])
    }
}


//
//  ImageDetailViewController.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit
import RxSwift
import RxCocoa

final class ImageDetailViewController: AppViewController {
    
    // MARK: - Properties
    
    public var coordinator: ImageDetailCoordinator?
    public var viewModel: ImageDetailViewModelProtocol?
    
    private let disposeBag = DisposeBag()
    
    let rootView = ImageDetailView()
    
    private lazy var tableDirector = TableDirector(
        tableView: rootView.tableView
    )
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        bindTableView()
        
        viewModel?.displayData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Image Detail"
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel?.sectionsRelay
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] sections in
                self?.tableDirector.sections = sections
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        tableDirector.onCellWillDisplay = { [weak self] indexPath, cell in
            guard let self = self else { return }
            
            self.viewModel?.fetchImage()
                .observe(on: MainScheduler.instance)
                .do(onNext: { image in
                    if let image = image, let cell = cell as? LargeImageTableViewCell {
                        cell.photoImageView.image = image
                    }
                })
                .subscribe()
                .disposed(by: self.disposeBag)
        }
    }
}

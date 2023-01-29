//
//  HomeViewController.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: AppViewController {
    
    // MARK: - Properties
    
    public var coordinator: HomeCoordinator?
    public var viewModel: HomeViewModelProtocol?
    
    private let disposeBag = DisposeBag()
    
    let rootView = HomeView()
    
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
        
        viewModel?.fetchPhotos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Photos"
    }
    
    // MARK: - Binding
    
    private func bindViewModel() {
        viewModel?.sectionRelay
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] section in
                self?.tableDirector.sections = [section]
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        tableDirector.onCellWillDisplay = { [weak self] indexPath, cell in
            guard let self = self else { return }
            
            self.viewModel?.fetchImage(for: indexPath.row)
                .observe(on: MainScheduler.instance)
                .do(onNext: { image in
                    if let image = image, let cell = cell as? ImageTableViewCell {
                        cell.photoImageView.image = image
                    }
                })
                .subscribe()
                .disposed(by: self.disposeBag)
        }
        
        tableDirector.onCellSelection = { [weak self] indexPath in
            guard let photo = self?.viewModel?.photos[indexPath.row] else { return }
            self?.coordinator?.coordinateToDetail(for: photo)
        }
    }
}

//
//  RegisterViewController.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: AppViewController {

    // MARK: - Properties
    
    public var coordinator: RegisterCoordinator?
    public var viewModel: RegisterViewModelProtocol?
    
    private let disposeBag = DisposeBag()
    
    private let rootView = RegisterView()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
          
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTextFields()
        bindRegisterButton()
    }
    
    // MARK: - Binding
    
    private func bindTextFields() {
        rootView.emailTextFieldView.textField.rx.text
            .do(onNext: { [weak self] text in
                self?.viewModel?.email.accept(text ?? "")
            })
            .subscribe()
            .disposed(by: disposeBag)
                
        rootView.passwordTextFieldView.textField.rx.text
            .do(onNext: { [weak self] text in
                self?.viewModel?.password.accept(text ?? "")
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        rootView.datePicker.rx.date
            .skip(1)
            .do(onNext: { [weak self] date in
                self?.rootView.dateOfBirthTextFieldView.textField.text = self?.dateFormatter.string(from: date)
            })
            .compactMap {
                let ageComponents: DateComponents = Calendar.current.dateComponents(
                    [.year],
                    from: $0,
                    to: Date()
                )
                return ageComponents.year
            }
            .do(onNext: { [weak self] age in
                self?.viewModel?.age.accept(age)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        viewModel?.isEmailValid
            .do(onNext: { [weak self] isValid in
                if isValid {
                    self?.rootView.emailTextFieldView.hideError()
                } else {
                    self?.rootView.emailTextFieldView.showError(text: "Email must be valid")
                }
            })
            .subscribe()
            .disposed(by: disposeBag)
                
        viewModel?.isPasswordValid
            .do(onNext: { [weak self] isValid in
                if isValid {
                    self?.rootView.passwordTextFieldView.hideError()
                } else {
                    self?.rootView.passwordTextFieldView.showError(text: "Must be between 6 and 12 characters")
                }
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        viewModel?.isAgeValid
            .subscribe { [weak self] isValid in
                if isValid {
                    self?.rootView.dateOfBirthTextFieldView.hideError()
                } else {
                    self?.rootView.dateOfBirthTextFieldView.showError(text: "Must be between 18 and 99 years")
                }
            }
            .disposed(by: disposeBag)
        
        viewModel?.isRegisterButtonEnabled
            .do(onNext: { [weak self] isEnabled in
                self?.rootView.registerButton.isEnabled = isEnabled
                self?.rootView.registerButton.backgroundColor = isEnabled ? .systemBlue : .lightGray
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bindRegisterButton() {
        rootView.registerButton.rx.tap
            .flatMap { [unowned self] in self.viewModel?.register() ?? .just(false) }
            .filter { $0 == true }
            .do(onNext: { [weak self] _ in
                self?.coordinator?.coordinateToHome()
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}



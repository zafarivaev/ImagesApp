//
//  LoginViewController.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 27/01/23.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: AppViewController {

    public var coordinator: LoginCoordinator?
    public var viewModel: LoginViewModelProtocol?
    
    private let disposeBag = DisposeBag()
    
    private let rootView = LoginView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTextFields()
        bindLoginButton()
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

        viewModel?.isLoginButtonEnabled
            .do(onNext: { [weak self] isEnabled in
                self?.rootView.loginButton.isEnabled = isEnabled
                self?.rootView.loginButton.backgroundColor = isEnabled ? .systemBlue : .lightGray
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bindLoginButton() {
        rootView.loginButton.rx.tap
            .flatMap { [unowned self] in self.viewModel?.login() ?? .just(false) }
            .filter { $0 == true }
            .do(onNext: { [weak self] _ in
                self?.coordinator?.coordinateToHome()
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func bindRegisterButton() {
        rootView.registerButton.rx.tap
            .do(onNext: { [weak self] _ in
                self?.coordinator?.coordinateToRegister()
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}


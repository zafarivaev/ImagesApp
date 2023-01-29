//
//  LoginViewModel.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import RxSwift
import RxCocoa

protocol LoginViewModelProtocol: AnyObject {
    var email: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    
    var isEmailValid: PublishRelay<Bool> { get }
    var isPasswordValid: PublishRelay<Bool> { get }
    
    var isLoginButtonEnabled: BehaviorRelay<Bool> { get }
    
    func login() -> Observable<Bool>
}

final class LoginViewModel: LoginViewModelProtocol {
    
    private let authService: AuthServiceProtocol
    
    private let disposeBag = DisposeBag()
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    let isEmailValid = PublishRelay<Bool>()
    let isPasswordValid = PublishRelay<Bool>()
    
    let isLoginButtonEnabled = BehaviorRelay<Bool>(value: false)
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        
        bindEmailAndPassword()
    }
    
    func login() -> Observable<Bool> {
        authService.login(email: email.value, password: password.value)
    }
    
    // MARK: - Binding
    
    private func bindEmailAndPassword() {
        email
            .filter { !$0.isEmpty }
            .compactMap { $0.isValidEmail() }
            .bind(to: isEmailValid)
            .disposed(by: disposeBag)
        
        password
            .filter { !$0.isEmpty }
            .compactMap { $0.isValidPassword() }
            .bind(to: isPasswordValid)
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(
                isEmailValid,
                isPasswordValid
            )
            .map { isEmailValid, isPasswordValid in
                return isEmailValid && isPasswordValid
            }
            .subscribe(onNext: { [weak self] allValid in
                self?.isLoginButtonEnabled.accept(allValid)
            })
            .disposed(by: disposeBag)
    }
}

//
//  RegisterViewModel.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import RxSwift
import RxCocoa

protocol RegisterViewModelProtocol: AnyObject {
    var email: BehaviorRelay<String> { get }
    var password: BehaviorRelay<String> { get }
    var age: BehaviorRelay<Int?> { get }
    
    var isEmailValid: PublishRelay<Bool> { get }
    var isPasswordValid: PublishRelay<Bool> { get }
    var isAgeValid: PublishRelay<Bool> { get }
    
    var isRegisterButtonEnabled: BehaviorRelay<Bool> { get }
    
    func register() -> Observable<Bool>
}

final class RegisterViewModel: RegisterViewModelProtocol {
    
    private let authService: AuthServiceProtocol
    
    private let disposeBag = DisposeBag()
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let age = BehaviorRelay<Int?>(value: nil)
    
    let isEmailValid = PublishRelay<Bool>()
    let isPasswordValid = PublishRelay<Bool>()
    let isAgeValid = PublishRelay<Bool>()
    
    let isRegisterButtonEnabled = BehaviorRelay<Bool>(value: false)
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        
        bindProperties()
    }
    
    func register() -> Observable<Bool> {
        guard let age = age.value else {
            return .just(false)
        }
        
        return authService.register(email: email.value, password: password.value, age: age)
    }
    
    // MARK: - Binding
    
    private func bindProperties() {
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
        
        age
            .compactMap { $0 }
            .map { $0 >= 12 && $0 <= 99 }
            .bind(to: isAgeValid)
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(
                isEmailValid,
                isPasswordValid,
                isAgeValid
            )
            .map { isEmailValid, isPasswordValid, isAgeValid in
                return isEmailValid && isPasswordValid && isAgeValid
            }
            .subscribe(onNext: { [weak self] allValid in
                self?.isRegisterButtonEnabled.accept(allValid)
            })
            .disposed(by: disposeBag)
    }
}


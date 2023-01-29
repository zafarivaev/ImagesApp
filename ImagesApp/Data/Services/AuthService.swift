//
//  AuthService.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import RxSwift

protocol AuthServiceProtocol: AnyObject {
    func login(email: String, password: String) -> Observable<Bool>
    func register(email: String, password: String, age: Int) -> Observable<Bool>
}

final class AuthServiceMock: AuthServiceProtocol {
    
    func login(email: String, password: String) -> Observable<Bool> {
        Observable.create { observer in
            observer.onNext(true)
            
            return Disposables.create()
        }
    }
    
    func register(email: String, password: String, age: Int) -> Observable<Bool> {
        Observable.create { observer in
            observer.onNext(true)
            
            return Disposables.create()
        }
    }
}

//
//  NetworkClient.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import RxSwift

protocol NetworkClientProtocol: AnyObject {
    func get<T: Decodable>(
        _ type: T.Type,
        url: URL
    ) -> Observable<Result<T, Error>>
    
    func getData(
        _ url: URL
    ) -> Observable<Result<Data, Error>>
}
final class NetworkClient: NetworkClientProtocol {
    func get<T: Decodable>(
        _ type: T.Type,
        url: URL
    ) -> Observable<Result<T, Error>> {
        return Observable.create { observer in
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data,
                      let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                    
                    if let error = error {
                        observer.onNext(.failure(error))
                    } else {
                        observer.onNext(.failure(NetworkingError.unknown))
                    }
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(type, from: data)
                    observer.onNext(.success(model))
                } catch {
                    observer.onNext(.failure(NetworkingError.decodingFailed))
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    func getData(_ url: URL) -> Observable<Result<Data, Error>> {
        return Observable.create { observer in
            let session = URLSession(configuration: .ephemeral)
                
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data,
                    let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                        if let error = error {
                            observer.onNext(.failure(error))
                        } else {
                            observer.onNext(.failure(NetworkingError.unknown))
                        }
                        return
                }
                
                observer.onNext(.success(data))
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

//
//  Endpoint+Pixabay.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import Foundation

extension Endpoint {
    static var photos: Self {
        return Endpoint(
            path: "api/",
            queryItems: [
                URLQueryItem(
                    name: "key",
                    value: "33212287-868aeec19f44b10ae44d2a6dc"
                ),
                URLQueryItem(
                    name: "page",
                    value: "1"
                )
            ]
        )
    }
}

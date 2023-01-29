//
//  UIView+ReuseIdentifier.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

public protocol ReuseIdentifiable {
    static var reuseIdentifer: String { get }
}

extension UIView: ReuseIdentifiable {
    
    public static var reuseIdentifer: String {
        return String(describing: self)
    }
}

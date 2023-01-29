//
//  TitleHeaderViewModel.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import Foundation

public struct TitleHeaderViewModel: TableHeaderFooterModel {
    public var identifier: String = TitleHeaderView.reuseIdentifer
    public let title: String
}


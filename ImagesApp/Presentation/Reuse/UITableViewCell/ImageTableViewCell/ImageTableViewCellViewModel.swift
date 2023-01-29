//
//  ImageTableViewCellViewModel.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

struct ImageTableViewCellViewModel: TableRowModel {
    let identifier = String(describing: ImageTableViewCell.self)

    let author: String
}

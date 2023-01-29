//
//  TwoTitlesTableViewCellViewModel.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

struct TwoTitlesTableViewCellViewModel: TableRowModel {
    let identifier = String(describing: TwoTitlesTableViewCell.self)
    
    let mainTitle: String
    let detailTitle: String
}


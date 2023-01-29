//
//  TitleHeaderView.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class TitleHeaderView: BaseHeaderFooterView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 24)
    }
    
    // MARK: - Setup
    override func setup(with headerFooterModel: TableHeaderFooterModel) {
        guard let model = headerFooterModel as? TitleHeaderViewModel else {
            return
        }
        
        titleLabel.text = model.title
    }
    
    // MARK: - Subviews
    
    @IBOutlet var titleLabel: UILabel!
}


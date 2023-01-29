//
//  TwoTitlesTableViewCell.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class TwoTitlesTableViewCell: BaseTableViewCell {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        
        mainLabel.font = .systemFont(ofSize: 17, weight: .medium)
        detailLabel.font = .systemFont(ofSize: 17, weight: .regular)
        detailLabel.numberOfLines = 0
        detailLabel.textAlignment = .right
        mainLabel.textColor = .black
        detailLabel.textColor = .black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        mainLabel.text = nil
        detailLabel.text = nil
    }
    
    override func setup(with rowModel: TableRowModel) {
        guard let viewModel = rowModel as? TwoTitlesTableViewCellViewModel else { return }
        
        mainLabel.text = viewModel.mainTitle
        detailLabel.text = viewModel.detailTitle
    }
}

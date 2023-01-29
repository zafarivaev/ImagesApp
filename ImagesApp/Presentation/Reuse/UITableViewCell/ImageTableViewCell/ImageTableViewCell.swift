//
//  ImageTableViewCell.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class ImageTableViewCell: BaseTableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        authorLabel.textColor = .black
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        authorLabel.text = nil
    }
    
    override func setup(with rowModel: TableRowModel) {
        guard let viewModel = rowModel as? ImageTableViewCellViewModel else { return }
        
        authorLabel.text = viewModel.author
    }
}

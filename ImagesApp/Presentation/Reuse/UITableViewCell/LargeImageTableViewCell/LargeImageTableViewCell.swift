//
//  LargeImageTableViewCell.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class LargeImageTableViewCell: BaseTableViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        contentView.backgroundColor = .white
        selectionStyle = .none
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
}


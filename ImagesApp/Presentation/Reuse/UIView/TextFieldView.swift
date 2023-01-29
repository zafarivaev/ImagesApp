//
//  TextFieldView.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class TextFieldView: UIView {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Properties
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: - Actions
    
    public func showError(text: String) {
        titleLabel.text = text
        titleLabel.textColor = .systemRed
        textField.layer.borderColor = UIColor.systemRed.cgColor
    }
    
    public func hideError() {
        titleLabel.text = title
        titleLabel.textColor = .black
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - Subviews
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var textField: UITextField = {
        let textField = AppTextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: - UI Setup
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.leftAnchor.constraint(equalTo: leftAnchor),
            textField.rightAnchor.constraint(equalTo: rightAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}

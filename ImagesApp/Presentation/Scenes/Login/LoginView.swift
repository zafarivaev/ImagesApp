//
//  LoginView.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class LoginView: UIView {
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Subviews
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    public lazy var emailTextFieldView: TextFieldView = {
        let view = TextFieldView()
        view.textField.placeholder = "Email"
        view.title = "Enter your email:"
        view.textField.keyboardType = .emailAddress
        return view
    }()
    
    public lazy var passwordTextFieldView: TextFieldView = {
        let view = TextFieldView()
        view.textField.placeholder = "Password"
        view.title = "Enter your password:"
        view.textField.isSecureTextEntry = true
        return view
    }()
    
    public lazy var loginButton: UIButton = {
        let button = AppButton()
        button.setTitle("Login", for: .normal)
        return button
    }()
    
    public lazy var registerButton: UIButton = {
        let button = AppButton()
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(emailTextFieldView)
        stackView.addArrangedSubview(passwordTextFieldView)
        stackView.addArrangedSubview(loginButton)
        addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.widthAnchor.constraint(equalTo: stackView.widthAnchor)
        ])
    }
}

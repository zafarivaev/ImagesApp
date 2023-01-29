//
//  RegisterView.swift
//  ImagesApp
//
//  Created by Zafar Ivaev on 29/01/23.
//

import UIKit

final class RegisterView: UIView {
    
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
    
    public lazy var dateOfBirthTextFieldView: TextFieldView = {
        let view = TextFieldView()
        view.textField.placeholder = "Date of birth"
        view.title = "Enter your date of birth:"
        view.textField.inputView = datePicker
        return view
    }()
    
    public lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.timeZone = TimeZone.current
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        return datePicker
    }()
    
    public lazy var registerButton: UIButton = {
        let button = AppButton()
        button.setTitle("Register", for: .normal)
        return button
    }()
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(emailTextFieldView)
        stackView.addArrangedSubview(passwordTextFieldView)
        stackView.addArrangedSubview(dateOfBirthTextFieldView)
        stackView.addArrangedSubview(registerButton)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
}


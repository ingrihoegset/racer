//
//  LoginViewController.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = Constants.accentColorDark
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.backgroundColor = Constants.whiteColor
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = Constants.smallCornerRadius
        field.layer.borderWidth = Constants.borderWidth
        field.layer.borderColor = Constants.accentColorDark?.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.backgroundColor = Constants.whiteColor
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = Constants.smallCornerRadius
        field.layer.borderWidth = Constants.borderWidth
        field.layer.borderColor = Constants.accentColorDark?.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        return field
    }()
    
    private let logginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = Constants.accentColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.smallCornerRadius
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.mainColor
        title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))

        emailField.delegate = self
        passwordField.delegate = self
        
        // Adding subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(logginButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/3
        imageView.frame = CGRect(x: (scrollView.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageView.layer.cornerRadius = imageView.width/2
        emailField.frame = CGRect(x: Constants.sideSpacing,
                                 y: imageView.bottom + 10,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
        passwordField.frame = CGRect(x: Constants.sideSpacing,
                                 y: emailField.bottom + 10,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
        logginButton.frame = CGRect(x: Constants.sideSpacing,
                                 y: passwordField.bottom + 10,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
    }

    func alertUserLoginError() {
        let alert = UIAlertController(title: "Whoops",
                                      message: "Please enter all information to log in",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        present(alert, animated: true)
    }
    
    @objc private func loginButtonTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count>=6 else {
            alertUserLoginError()
            return
        }
        
        //Firebase log in
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
            }
            
            let user = result.user
            print("Logged in User: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        
        return true
    }
}

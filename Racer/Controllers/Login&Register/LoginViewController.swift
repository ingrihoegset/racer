//
//  LoginViewController.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

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
    
    private let fbLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        // To override height property inherent in fb button
        button.removeConstraints(button.constraints)
        button.permissions = ["public_profile", "email"]
        return button
    }()
    
    private let googleLoginButton: GIDSignInButton = {
        let button = GIDSignInButton()
        // To override height property inherent in fb button
        button.removeConstraints(button.constraints)
        return button
    }()
    
    private var googleLoginObserver: NSObjectProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.mainColor
        title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Subscribe to notifications from Google sign in completion
        googleLoginObserver = NotificationCenter.default.addObserver(forName: .didLogInNotification, object: nil, queue: .main, using: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            // Dismisses login controller when google login is succesful
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })

        emailField.delegate = self
        passwordField.delegate = self
        fbLoginButton.delegate = self
        
        // Adding subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(logginButton)
        
        // Facebook login button
        scrollView.addSubview(fbLoginButton)
        
        // Google login button
        scrollView.addSubview(googleLoginButton)
    }
    
    deinit {
        if let observer = googleLoginObserver {
            NotificationCenter.default.removeObserver(observer)
        }
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
        fbLoginButton.center = scrollView.center
        fbLoginButton.frame = CGRect(x: Constants.sideSpacing,
                                 y: logginButton.bottom + 20,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
        googleLoginButton.frame = CGRect(x: Constants.sideSpacing,
                                 y: fbLoginButton.bottom + 10,
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

// If user choses to log in via Facebook
extension LoginViewController: LoginButtonDelegate {
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // No operation
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        // Unwraps token from Facebook
        guard let token = result?.token?.tokenString else {
            print("User failed to sign in with facebook.")
            return
        }
        
        // Makes a requestobject to Facebook to get the email and name from the logged in user
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields": "email, name"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
        
        // Executes the request to Facebook
        facebookRequest.start(completionHandler: { _, result, error in
            guard let result = result as? [String: Any], error == nil else {
                print("failed to make facebook graph request")
                return
            }
            
            // Unwrapping data from Facebook get-request
            guard let userName = result["name"] as? String,
                  let email = result["email"] as? String else {
                print("Failed to get name and email from FB get")
                return
            }
            
            // --- OBS!!! --- Unwrap actual names //
            // Splits the name to get the first and last names seperated
            let nameComponents = userName.components(separatedBy: " ")
            guard nameComponents.count == 3 else {
                return
            }
            
            let firstName = nameComponents[0]
            let lastName = nameComponents[1]
            
            // Checking if user exists in database already
            DatabaseManager.shared.userExists(with: email, completion: { exists in
                // If user doesnt exist already, we insert it into the database
                if !exists {
                    DatabaseManager.shared.insertUser(with: RaceAppUser(firstName: firstName,
                                                                        lastName: lastName,
                                                                        emailAddress: email))
                }
            })
            
            // Create credential and then sign the user in
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            FirebaseAuth.Auth.auth().signIn(with: credential, completion: { [weak self] authResult, error in
                guard let strongSelf = self else {
                    return
                }
                
                guard authResult != nil, error == nil else {
                    if let error = error {
                        print("Facebook credential login failed, MFA may be needed. - \(error)")
                    }

                    return
                }
                
                // Dismiss navigation controller to move to home page when log in is successful
                print("Successfully logged user in")
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        })
    }
}

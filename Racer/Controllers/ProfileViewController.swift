//
//  ProfileViewController.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let qrImageView: UIImageView = {
        let qrImageView = UIImageView()
        return qrImageView
    }()
    
    private let profileView: UIView = {
        let profileView = UIView()
        profileView.backgroundColor = Constants.accentColor
        return profileView
    }()
    
    private let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.borderColor = Constants.accentColorDark?.cgColor
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.masksToBounds = true
        return profileImageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapLogOut))
        
        view.addSubview(scrollView)
        scrollView.addSubview(profileView)
        profileView.addSubview(profileImageView)
        scrollView.addSubview(qrImageView)
        
        createUserSpecificInterface()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = scrollView.width/2
        
        profileView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: self.view.width,
                                 height: 200)
        
        profileImageView.frame = CGRect(x: (profileView.width-150)/2,
                                        y: 25,
                                        width: 150,
                                        height: 150)
        profileImageView.layer.cornerRadius = 150/2
        
        qrImageView.frame = CGRect(x: (scrollView.width-size)/2,
                                   y: profileView.bottom,
                                 width: size,
                                 height: size)
    }
    
    
    @objc func didTapLogOut() {
        
        let actionSheet = UIAlertController(title: "Are you sure you'd like to log out?",
                                      message: "",
                                      preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Log Out",
                                      style: .destructive,
                                      handler: { [weak self] _ in
                                        
                                        guard let strongSelf = self else {
                                            return
                                        }
                                        
                                        // Log out from facebook
                                        FBSDKLoginKit.LoginManager().logOut()
                                        
                                        // Log out from Google
                                        GIDSignIn.sharedInstance()?.signOut()
                                        
                                        do {
                                            // Telling Firebase to log user out
                                            try FirebaseAuth.Auth.auth().signOut()
                                            
                                            let vc = LoginViewController()
                                            let nav = UINavigationController(rootViewController: vc)
                                            nav.modalPresentationStyle = .fullScreen
                                            strongSelf.present(nav, animated: true)
                                        }
                                        catch {
                                            print("Failed to log out")
                                        }
                                        
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        
        present(actionSheet, animated: true)
    }
    
    private func createUserSpecificInterface() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String
        else {
            print("No email found")
            return
        }
        
        // Draw a QR-code that contains user's email as key
        createUserSpecificQRCodeIImage(userIdentifier: email)
        
        // Convert email to safeemail, in order to download correct file from firebase
        let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
        let filename = safeEmail + "_profile_picture.png"
        let path = "images/" + filename
        
        // Downloading image from Firebase Storage
        StorageManager.shared.downloadURL(for: path, completion: { [weak self] result in switch result {
            case .success(let url):
                self?.downloadProfileImage(url: url)
            case .failure(let error):
                print("Failed to get download url: \(error)")
            }
        })
    }
    
    func createUserSpecificQRCodeIImage(userIdentifier: String) {
        DispatchQueue.main.async {
            self.qrImageView.image = self.generateQRCodeImage(userIdentifier: userIdentifier)
            self.qrImageView.layer.magnificationFilter = CALayerContentsFilter.nearest
        }
    }
    
    func downloadProfileImage(url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.profileImageView.image = image
            }
        }).resume()
    }
    

    
    private func generateQRCodeImage(userIdentifier: String) -> UIImage {
        let data = userIdentifier.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        let qrImage = UIImage(ciImage: (filter?.outputImage)!)
        return qrImage
    }

}

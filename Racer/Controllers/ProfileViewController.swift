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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapLogOut))
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

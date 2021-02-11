//
//  HomeViewController.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        // test
        super.viewDidLoad()
        view.backgroundColor = .link

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = .white
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }


}



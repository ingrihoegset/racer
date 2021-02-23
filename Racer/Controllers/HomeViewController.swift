//
//  HomeViewController.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        // test
        super.viewDidLoad()
        view.backgroundColor = Constants.mainColor
        
        // Temporary button for linking to user
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(didTapLinkToPartnerButton))

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
    
    @objc private func didTapLinkToPartnerButton() {
        let vc = LinkToPartnerViewController()
        vc.completion = { [weak self] result in
            print("result\(result)")
            self?.goToSetUpWithPartner(partnerId: result)
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    func goToSetUpWithPartner(partnerId: String) {
        let vc = SetUpRaceWithPartnerViewController()
        vc.partnerId = partnerId
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }


}



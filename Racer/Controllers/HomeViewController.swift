//
//  HomeViewController.swift
//  Racer
//
//  Created by Ingrid on 11/02/2021.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let singleGateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("Single gate", for: .normal)
        return button
    }()
    
    private let twoGateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("Two gates", for: .normal)
        button.addTarget(self, action: #selector(didTapLinkToPartnerButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        // test
        super.viewDidLoad()
        view.backgroundColor = Constants.mainColor

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Checks if user is logged in or not and sends to correct view
        validateAuth()
        
        // Set up display
        view.addSubview(scrollView)
        scrollView.addSubview(singleGateButton)
        scrollView.addSubview(twoGateButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
    
        singleGateButton.frame = CGRect(x: Constants.sideSpacing,
                                        y: Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeightLarge)
        
        twoGateButton.frame = CGRect(x: Constants.sideSpacing,
                                     y: singleGateButton.bottom + Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeightLarge)
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
            self?.goToSetUpWithPartner(partnerId: result[0], raceId: result[1])
        }
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    func goToSetUpWithPartner(partnerId: String, raceId: String) {
        let vc = RaceTypeViewController()
        vc.partnerId = partnerId
        vc.raceId = raceId
        vc.title = "Select Race Type"
        vc.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(vc, animated: true)
    }


}



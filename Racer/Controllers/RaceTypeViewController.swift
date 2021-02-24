//
//  SetUpRaceWithPartnerViewController.swift
//  Racer
//
//  Created by Ingrid on 23/02/2021.
//

import UIKit

class RaceTypeViewController: UIViewController {
    
    var partnerId = ""
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let speedRaceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("Speed Race", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapRaceType), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private let reactionRaceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("Reaction Race", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapRaceType), for: .touchUpInside)
        button.tag = 2
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.whiteColor
        view.addSubview(scrollView)
        scrollView.addSubview(speedRaceButton)
        scrollView.addSubview(reactionRaceButton)

        print("pid", partnerId)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
    
        speedRaceButton.frame = CGRect(x: Constants.sideSpacing,
                                        y: Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeightLarge)
        
        reactionRaceButton.frame = CGRect(x: Constants.sideSpacing,
                                     y: speedRaceButton.bottom + Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeightLarge)
    }
    
    @objc func didTapSendTimeStamp() {
        print("Tapped timestamp button")
    }
    
    @objc func didTapRaceType(_ sender: UIButton) {
        
        if (sender.tag == 1) {
        }
        else {
        }
        goToRaceDetails()
    }
    
        
    func goToRaceDetails() {
        let vc = RaceDetailsViewController()
        vc.partnerId = partnerId
        navigationController?.pushViewController(vc, animated: true)
    }
}

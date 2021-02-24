//
//  raceDetailsSetUpViewController.swift
//  Racer
//
//  Created by Ingrid on 24/02/2021.
//

import UIKit

class RaceDetailsViewController: UIViewController {
    
    var partnerId = ""
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let newRaceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("New Race", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapNewRace), for: .touchUpInside)
        button.tag = 1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Set Race Details"
        view.backgroundColor = Constants.whiteColor
        view.addSubview(scrollView)
        scrollView.addSubview(newRaceButton)
        
        print(partnerId)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
    
        newRaceButton.frame = CGRect(x: Constants.sideSpacing,
                                     y: scrollView.height - Constants.fieldHeight - Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
        
    }
    
    @objc private func didTapNewRace() {
        let vc = StartGateViewController()
        vc.partnerId = partnerId
        navigationController?.pushViewController(vc, animated: true)
    }



}

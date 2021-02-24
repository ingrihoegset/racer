//
//  StartGateViewController.swift
//  Racer
//
//  Created by Ingrid on 24/02/2021.
//
//

import UIKit

class StartGateViewController: UIViewController {
    
    var partnerId = ""
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let startRaceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("Start Count Down", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapStartCountDown), for: .touchUpInside)
        button.tag = 1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Start Race"
        view.backgroundColor = Constants.whiteColor
        view.addSubview(scrollView)
        scrollView.addSubview(startRaceButton)
        
        print("at race", partnerId)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
    
        startRaceButton.frame = CGRect(x: Constants.sideSpacing,
                                     y: scrollView.height - Constants.fieldHeight - Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
    }
    
    @objc private func didTapStartCountDown() {
        let date = Date()
        print(date)
        print(date.currentTimeMillis())
    }
    


}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

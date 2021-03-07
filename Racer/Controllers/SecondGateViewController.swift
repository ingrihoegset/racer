//
//  EndGateViewController.swift
//  Racer
//
//  Created by Ingrid on 06/03/2021.
//

import UIKit

class SecondGateViewController: UIViewController {
    
    var raceId = ""
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isUserInteractionEnabled = true
        return scrollView
    }()
    
    private let testStopRaceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.accentColor
        button.setTitle("Test send stop time", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapStopTime), for: .touchUpInside)
        button.tag = 1
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        title = "End Gate"
        
        view.addSubview(scrollView)
        scrollView.addSubview(testStopRaceButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.safeAreaLayoutGuide.layoutFrame
        
        testStopRaceButton.frame = CGRect(x: Constants.sideSpacing,
                                     y: scrollView.height - Constants.fieldHeight * 3 - Constants.verticalSpacing,
                                 width: scrollView.width - Constants.sideSpacing * 2,
                                 height: Constants.fieldHeight)
    }
    
    @objc private func didTapStopTime() {
        
        let currentTime = Date().currentTimeMillis()
        
        DatabaseManager.shared.sendEndTimestamp(to: raceId, timestamp: currentTime, completion: { [weak self] success in
            guard let strongSelf = self else {
                return
            }
            if success {
                print ("stop time sent")
                strongSelf.goToResults()
            }
            else {
                print("stop time failed to send")
            }
        })
    }
    
    private func goToResults() {
        let vc = ResultsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
